UDF1.show()
PROCESS_NAME = 'PixelWorlds.exe'
local autoAttachTimer = nil ---- variable to hold timer object
local autoAttachTimerInterval = 1000 ---- Timer intervals are in milliseconds
local autoAttachTimerTicks = 0 ---- variable to count number of times the timer has run
local autoAttachTimerTickMax = 5000 ---- Set to zero to disable ticks max
local function autoAttachTimer_tick(timer) ---- Timer tick call back
        ---- Destroy timer if max ticks is reached
    if autoAttachTimerTickMax > 0 and autoAttachTimerTicks >= autoAttachTimerTickMax then
        timer.destroy()
    end
        ---- Check if process is running
    if getProcessIDFromProcessName(PROCESS_NAME) ~= nil then
        timer.destroy() ---- Destroy timer
        openProcess(PROCESS_NAME) ---- Open the process
        UDF1.CEImage3.visible = true
        UDF1.CEImage4.visible = false
        LaunchMonoDataCollector()
    end
    autoAttachTimerTicks = autoAttachTimerTicks + 1 ---- Increase ticks
end
autoAttachTimer = createTimer(getMainForm()) ---- Create timer with the main form as it's parent
autoAttachTimer.Interval = autoAttachTimerInterval ---- Set timer interval
autoAttachTimer.OnTimer = autoAttachTimer_tick ---- Set timer tick call back

function UDF1_FormMouseDown(sender, button, x, y)
UDF1.dragNow()
end

pa1=0
function UDF1_CEPanel1Click(sender)
pa1=pa1+1
if pa1==1 then
UDF1.CEPanel1.setColor(0x7FFF00)
autoAssemble([[
Player.HitPlayerFromAIEnemy:
db C3
]]);
end
if pa1==2 then
UDF1.CEPanel1.setColor(255)
autoAssemble([[
Player.HitPlayerFromAIEnemy:
db 4C
]]);
pa1=0
end
end
