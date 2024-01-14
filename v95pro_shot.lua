EnablePrimaryMouseButtonEvents(true)
isRightButtonDown = false

local function click_random_left_mouse()
    OutputLogMessage("模拟鼠标左键点击开始\n")
    PressMouseButton(1)
    local sleepTimePress = math.random(40, 50)
    OutputLogMessage("按下延时: "..sleepTimePress.."ms\n")
    Sleep(sleepTimePress)
    ReleaseMouseButton(1)
    local sleepTimeRelease = math.random(40, 60)
    OutputLogMessage("释放延时: "..sleepTimeRelease.."ms\n")
    Sleep(sleepTimeRelease)
    OutputLogMessage("模拟鼠标左键点击结束\n")
end

function OnEvent(event, arg)
    if not IsKeyLockOn("capslock") then
        OutputLogMessage("大写锁定未开启，脚本未运行\n")
        return
    end

    if event == "MOUSE_BUTTON_PRESSED" then
        if arg == 2 then
            isRightButtonDown = true
            OutputLogMessage("鼠标右键按下，准备进行自动点击\n")
        elseif arg == 1 and isRightButtonDown then
            OutputLogMessage("开始自动点击\n")
            repeat
                click_random_left_mouse()
            until not IsMouseButtonPressed(3)
            OutputLogMessage("鼠标右键释放，自动点击停止\n")
        end
    elseif event == "MOUSE_BUTTON_RELEASED" and arg == 2 then
        isRightButtonDown = false
        OutputLogMessage("鼠标右键释放\n")
    end
end
