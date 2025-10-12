-- [[ Cute Spy v1.0 ]] --

-- [[ Main Code ]] --
local a, b, c

if not hookfunction then
	print("injector issue")
	return
end

print("Cute Spy")

local function notify(skibidiparam)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "check log.txt",
		Text = skibidiparam,
		Duration = 3
	})
end

a = hookfunction(game.HttpGet, function(self, url, ...)
	appendfile("log.txt", "game.HttpGet -> " .. url .. "\n")
	notify("game:HttpGet/game.HttpGet detected")
	return a(self, url, ...)
end)

b = hookfunction(http_request, function(skibidi)
	local method = skibidi.Method or "unknown"
	local url = skibidi.Url or "unknown"
	local body = skibidi.Body or ""
	appendfile("log.txt", "http_request{" .. method .. "} -> " .. url .. "\n" .. body .. "\n")
	notify("http_request detected")
	return b(skibidi)
end)

c = hookfunction(http.request, function(skibidi)
	local method = skibidi.Method or "unknown"
	local url = skibidi.Url or "unknown"
	local body = skibidi.Body or ""
	appendfile("log.txt", "http.request{" .. method .. "} -> " .. url .. "\n" .. body .. "\n")
	notify("http.request detected")
	return c(skibidi)
end)
