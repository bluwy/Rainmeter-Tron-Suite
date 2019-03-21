
[Variables]
Multiplier=8
; Higher Multiplier will increase the pulse value and may cause the glow be more white-ish

[MeasureAudio]
Measure=Plugin
Plugin=AudioLevel
Port=Output
RMSAttack=300
RMSDecay=300
RMSGain=1.0
PeakAttack=0
PeakDecay=0
PeakGain=1
FFTSize=4096
FFTAttack=0
FFTDecay=50
FreqMin=20
FreqMax=16000
Sensitivity=30

[AudioValue]
Measure=Calc
Formula=(MeasureAudio*#Multiplier#)
