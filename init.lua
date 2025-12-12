local englishApps = {
      ["ターミナル"] = true,
      ["Emacs"] = true,
      ["WezTerm"] = true,
}

local japaneseApps = {
      ["Obsidian"] = true,
}

local appWatcher = hs.application.watcher.new(function(appName, eventType, appObject)
    if eventType == hs.application.watcher.activated then
        if englishApps[appName] then
            hs.keycodes.setLayout("ABC") -- should use `setLayout` 英語入力に切り替え
        elseif japaneseApps[appName] then
            hs.keycodes.setMethod("Hiragana") -- should use `setMethod` 日本語入力に切り替え
	end
    end
end)

appWatcher:start()
