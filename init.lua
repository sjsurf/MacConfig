-- Virable Define
local key2App = {
    a = 'Safari',
    e = 'Sublime Text',
    d = 'DingTalk',
    f = 'Finder',
    g = 'Google Chrome',
    r = 'UlyssesMac',
    m = 'Mail',
    p = 'Zeplin',
    q = 'NeteaseMusic',
    s = 'Notion',
    t = 'iTerm',
    w = 'WeChat',
    x = 'Xcode',
    z = 'Visual Studio Code',
    l = 'Launchpad',
}

local key2WindowMove = {
    Left = 1,
    Right = 2,
    Up = 3,
    Down = 4,
    u = 5,
    i = 6,
    j = 7,
    k = 8,
}

-- 如果切换屏幕有问题   读取一下屏幕数据，最后有读取显示器的方法
local sortedScreenNames = {'VX2780-4K-HDU', 'DELL U3219Q'}

local hyper = hs.hotkey.modal.new({}, nil)
hyper.pressed = function() hyper:enter() end
hyper.released = function() hyper:exit() end

local screenMoveHyper = hs.hotkey.modal.new({}, nil)
screenMoveHyper.pressed = function() screenMoveHyper:enter() end
screenMoveHyper.released = function() screenMoveHyper:exit() end


hs.hotkey.bind({}, 'F19', hyper.pressed, hyper.released)
hs.hotkey.bind({'cmd'}, 'F19', screenMoveHyper.pressed, screenMoveHyper.released)


-- Virable Define

-- Window Functions Start
function windowMove(direction)
    -- print(hs.window.focusedWindow()
    local win = hs.window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    if direction == 1 then

        winFrame.x = screenFrame.x
        winFrame.y = screenFrame.y
        winFrame.w = screenFrame.w / 2
        winFrame.h = screenFrame.h

    elseif direction == 2 then

        winFrame.x = screenFrame.w / 2
        winFrame.y = screenFrame.y
        winFrame.w = screenFrame.w / 2
        winFrame.h = screenFrame.h

    elseif direction == 3 then
        
        winFrame.x = screenFrame.x
        winFrame.y = screenFrame.y
        winFrame.w = screenFrame.w
        winFrame.h = screenFrame.h / 2

    elseif direction == 4 then

        winFrame.x = screenFrame.x
        winFrame.y = screenFrame.y + screenFrame.h / 2
        winFrame.w = screenFrame.w
        winFrame.h = screenFrame.h / 2

    elseif direction == 5 then

        winFrame.x = screenFrame.x
        winFrame.y = screenFrame.y
        winFrame.w = screenFrame.w / 2
        winFrame.h = screenFrame.h / 2

    elseif direction == 6 then

        winFrame.x = screenFrame.x + screenFrame.w / 2
        winFrame.y = screenFrame.y
        winFrame.w = screenFrame.w / 2
        winFrame.h = screenFrame.h / 2

    elseif direction == 7 then

        winFrame.x = screenFrame.x
        winFrame.y = screenFrame.y + screenFrame.h / 2
        winFrame.w = screenFrame.w / 2
        winFrame.h = screenFrame.h / 2

    elseif direction == 8 then

        winFrame.x = screenFrame.x + screenFrame.w / 2
        winFrame.y = screenFrame.y + screenFrame.h / 2
        winFrame.w = screenFrame.w / 2
        winFrame.h = screenFrame.h / 2

    elseif direction == 9 then
    	winFrame.x = screenFrame.x
        winFrame.y = screenFrame.y
        winFrame.w = screenFrame.w
        winFrame.h = screenFrame.h
    end

    win:setFrame(winFrame)
end
-- Window Functions End

-- ChangeInputSource Start

-- ChangeInputSource End

function ChangeInputSourceToEnglish()
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

function ChangeInputSourceToChinese()
    hs.keycodes.currentSourceID("com.sogou.inputmethod.sogou.pinyin")
end

-- Normal Functions Start
function applicationWatcher(appName, eventType, appObject)
    if eventType == hs.application.watcher.activated then
        if appName == "Finder" then
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end

        if appName == "WeChat" or appName == "Ulysses" then
            ChangeInputSourceToChinese()
        end

        if appName == "Xcode" or appName == "Safari" or appName == "iTerm" or appName == "Sublime Text" then
            ChangeInputSourceToEnglish()
        end
    end
end

function reloadConfig(files)
    doReload = false

    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end

    if doReload then
        hs.reload()
    end
end

function changeMousePosition(screenNum)
    if screenNum == 0 then
        currentScreenCenter = hs.mouse.getCurrentScreen():frame().center
        hs.mouse.setAbsolutePosition(currentScreenCenter)
        return
    end

    targetScreen = hs.screen(GetScreenIdByName(sortedScreenNames[screenNum]))
    
    screenCenterPosition = targetScreen:frame().center
    hs.mouse.setAbsolutePosition(screenCenterPosition)
end

function changeWindowPosition(left)

    allScreens = hs.screen.allScreens()
    win = hs.window.focusedWindow()
    currentScreen = win:screen()

    currentIdx =  ObjectIndexInTable(currentScreen:name(), sortedScreenNames)

    if left then
        if currentIdx - 1 > 0 then
            targetScreenId = GetScreenIdByName(sortedScreenNames[currentIdx - 1])
            win:moveToScreen(hs.screen(targetScreenId), false, true, 0)
        end
    else
        if currentIdx + 1 <= #(allScreens) then
            targetScreenId = GetScreenIdByName(sortedScreenNames[currentIdx + 1])
            win:moveToScreen(hs.screen(targetScreenId), false, true, 0)
        end
    end

end
-- Normal Functions End

-- HotKey Binding Start
hyper:bind({}, '0', function() changeMousePosition(0) end)
hyper:bind({}, '1', function() changeMousePosition(1) end)
hyper:bind({}, '2', function() changeMousePosition(2) end)
hyper:bind({}, '3', function() changeMousePosition(3) end)
hyper:bind({}, '9', function() print(GetAllScreenName()); GetCurrentInputSourceID() end) --读取所有需要的配置，可以在 Console 中查看

hyper:bind({}, 'return', function() windowMove(9) end)

screenMoveHyper:bind({'cmd'}, 'Left', function() changeWindowPosition(true) end)
screenMoveHyper:bind({'cmd'}, 'Right', function() changeWindowPosition(false) end)

for key, app in pairs(key2App) do

    hyper:bind({}, key, function() hs.application.launchOrFocus(app) end)

end


for key, value in pairs(key2WindowMove) do

    hyper:bind({}, key, function() windowMove(value) end)

end


-- HotKey Binding End
-- Watchers Start
--保存文件 Reload Config
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

--应用程序 状态变更监视器
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

--Watchers End

-- Private Function Start
function ObjectIndexInTable(object, table)

    index = {}
    for i = 1, #(table) do
        index[table[i]] = i
    end

    return index[object]
end

function GetScreenIdByName(screenName)
    allScreens = hs.screen.allScreens()
    allScreenInfo = {}

       for i=1,#allScreens do
        allScreenInfo[allScreens[i]:name()] = allScreens[i]:id()
    end
    return allScreenInfo[screenName]
end

function GetAllScreenName()
    allScreens = hs.screen.allScreens()

    for i=1,#allScreens do
        hs.console.printStyledtext(allScreens[i]:id())
        hs.console.printStyledtext(allScreens[i]:name())
    end
end

function GetCurrentInputSourceID()
    hs.console.printStyledtext(hs.keycodes.currentSourceID())
end

