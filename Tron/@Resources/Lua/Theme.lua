
function Initialize()
	-- Get theme count to calculate scrolling looping
	-- themeCount = GetTableCount(themePresets);

	themeCount = tonumber(SKIN:GetVariable('ThemeCount'))
	themeColor = ''

	-- This value will be floored throughout the script
	scrollIndex = math.floor(tonumber(SKIN:GetVariable('ScrollIndex')))

	-- The alpha of top and bottom theme name in display
	fadeAlpha = 80

	rootConfig = SKIN:GetVariable('ROOTCONFIG')

	-- Get the Y positions (center, top and bottom)
	centerY = tonumber(SKIN:ParseFormula(SKIN:GetVariable('CenterY')))
	topY = tonumber(SKIN:ParseFormula(SKIN:GetVariable('TopY')))
	bottomY = tonumber(SKIN:ParseFormula(SKIN:GetVariable('BottomY')))
end

-- Gets the y position of theme depending on its scroll index
function GetThemeY(index)
	local dif = scrollIndex - index

	if dif == 0 then
		return centerY
	elseif dif == 1 or (scrollIndex == 1 and index == themeCount) then
		return topY
	elseif dif == -1 or (scrollIndex == themeCount and index == 1) then
		return bottomY
	else
		return 0
	end
end

-- Get the alpha for display depending on the themes index
function GetThemeAlpha(index)
	local dif = math.abs(scrollIndex - tonumber(index))

	if dif == 0 then
		return 255
	elseif dif == 1 or (scrollIndex == 1 and index == themeCount) or (scrollIndex == themeCount and index == 1) then
		return fadeAlpha
	else
		return '0'
	end
end

-- Sets the theme of all the skins
function SetTheme(number)
	local themeName = SKIN:GetVariable('Theme' .. number)

	themeColor = SKIN:GetVariable('Color' .. number)

	if SKIN:GetVariable('CurrentTheme'):lower() == themeName:lower() then return end

	SKIN:Bang('!SetVariableGroup', 'CurrentColor', themeColor, rootConfig)
	SKIN:Bang('!UpdateGroup', rootConfig)
	SKIN:Bang('!RedrawGroup', rootConfig)

	-- Set variable and update self to enable current theme checkings, which is the if statement above
	SKIN:Bang('!SetVariable', 'CurrentTheme', themeName)
	SKIN:Bang('!UpdateMeasure', SELF:GetName())

	SKIN:Bang('!WriteKeyValue', 'Variables', 'CurrentTheme', themeName, '#@#Variables.inc')
	SKIN:Bang('!WriteKeyValue', 'Variables', 'CurrentColor', themeColor, '#@#Variables.inc')
end

function ClampScroll(index)
	index = (index - 1) % themeCount + 1

	-- write to 
	SKIN:Bang('!SetVariable', 'ScrollIndex', index)
	SKIN:Bang('!WriteKeyValue', 'Variables', 'ScrollIndex', index)

	-- set the floored version
	scrollIndex = math.floor(index)
end

-- Gets the table's element count
function GetTableCount(tbl)
	local count = 0
	for _ in pairs(tbl) do count = count + 1 end
	return count;
end
