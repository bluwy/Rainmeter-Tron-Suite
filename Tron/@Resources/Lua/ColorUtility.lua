function Initialize()
    r,g,b = 0,0,0
end

function InternalUpdate()
    local result = split(SKIN:GetVariable('CurrentColor'), ',', 3)

    r = result[1]
    g = result[2]
    b = result[3]
end

-- Copied from https://www.lua-users.org/wiki/SplitJoin
-- Added trimming 
function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end

    if maxNb == nil or maxNb < 1 then 
        maxNb = 0 -- No limit
    end

    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos = 0

    for part, pos in string.gmatch(str, pat) do
        local s = trim(part)

        if s ~= nil and s ~= "" then
            nb = nb + 1
            result[nb] = s
        end

        lastPos = pos

        if(nb == maxNb) then 
            break 
        end
    end

    if nb ~= maxNb then
        result[nb + 1] = trim(str:sub(lastPos))
    end

    return result
end

-- Copied from https://lua-users.org/wiki/CommonFunctions
-- remove trailing and leading whitespace from string
-- https://en.wikipedia.org/wiki/Trim_(programming)
function trim(s)
    -- from PiL2 20.4
    return s:gsub("^%s*(.-)%s*$", "%1")
end