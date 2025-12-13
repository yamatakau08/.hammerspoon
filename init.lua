local englishApps = {
      ["ターミナル"] = true,
      ["Emacs"] = true,
      ["emacs"] = true,
      ["WezTerm"] = true,
}

local japaneseApps = {
      ["Obsidian"] = true,
}

local lastSwitch = 0
local switchDelay = 0.3

-- AppleScriptでキーを送信
local function pressKeyViaAppleScript(keyCode)
    local script = string.format([[
        tell application "System Events"
            key code %d
        end tell
    ]], keyCode)

    hs.osascript.applescript(script)
end

local appWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
    if eventType == hs.application.watcher.activated then
        local now = hs.timer.secondsSinceEpoch()

        if now - lastSwitch < switchDelay then
            print("Skipped: ", appName)
            return
        end

        lastSwitch = now
        print("Switched to: ", appName)

        if englishApps[appName] then
            print("-> English ", appName)
            pressKeyViaAppleScript(102) -- 102 英数
        elseif japaneseApps[appName] then
            print("-> Japanese ", appName)
            pressKeyViaAppleScript(104) -- 104 かな
        else
            print("Other app: ", appName)
        end
    end
end)

appWatcher:start()
print("Started")

hs.timer.doEvery(10, function()
    print("Alive:", os.date("%H:%M:%S"))
end)