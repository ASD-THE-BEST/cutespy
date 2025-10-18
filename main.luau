-- [[ vars ]] --
local a, b, c -- for hooking!
skibidilog = nil -- the log
skibidiBreakStatus = true -- for break button
-- [[ vars end ]] --

-- [[ hooks ]] --
a = hookfunction(game.HttpGet, function(self, url, ...)
	if not skibidiBreakStatus then
		return c(skibidi)
	end
	skibidilog:AppendText("[+] game:HttpGet/game.HttpGet detected")
    skibidilog:AppendText("game.HttpGet -> " .. url .. "\n")
	return a(self, url, ...)
end)
b = hookfunction(http_request, function(skibidi)
	if not skibidiBreakStatus then
		return c(skibidi)
	end
	local method = skibidi.Method or "unknown"
	local url = skibidi.Url or "unknown"
	local body = skibidi.Body or ""
	skibidilog:AppendText("[+] http_request detected")
	skibidilog:AppendText("http_request{" .. method .. "} -> " .. url .. "\n" .. body .. "\n")
	return b(skibidi)
end)
c = hookfunction(http.request, function(skibidi)
	if not skibidiBreakStatus then
		return c(skibidi)
	end
	local method = skibidi.Method or "unknown"
	local url = skibidi.Url or "unknown"
	local body = skibidi.Body or ""
	skibidilog:AppendText("[+] http.request detected")
	skibidilog:AppendText("http.request{" .. method .. "} -> " .. url .. "\n" .. body .. "\n")
	return c(skibidi)
end)
-- [[ hooks end ]] --

local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()
-- i love this lib!!! docs : https://depso.gitbook.io/regui
local Window = ReGui:Window({
	Title = "CuteSpy",
	Size = UDim2.fromOffset(300, 400),
    NoResize = true

}):Center()

Window:Label({
	Text = "CuteSpy v1.0.1",
    Bold = true
})
Window:BulletText({
	Rows = {
		"1.0 -> 1.0.1 changelog : GUI!!!!"
	}
})

Window:Separator({Text="Main"})

Window:Button({
	Text = "Clear Log",
	Callback = function()
		skibidilog:Clear()
	end,
})
Window:Button({
	Text = "Break",
	Callback = function()
		skibidiBreakStatus = not skibidiBreakStatus
		if skibidiBreakStatus then
			skibidilog:AppendText("[/] Hooks resumed.")
		else
			skibidilog:AppendText("[/] Hooks Break.")
		end
	end,
})
Window:Button({
	Text = "Copy Log",
	Callback = function()
		setclipboard(skibidilog:GetValue())
		skibidilog:AppendText("[/] Successfully Copied")
	end,
})
Window:Button({
	Text = "Save Log",
	Callback = function()
		appendfile("cutespy.log", skibidilog:GetValue())
		skibidilog:AppendText("[/] Successfully Saved(Check workspace/Cutespy.log)")
	end,
})

skibidilog = Window:Console({
    LineNumbers = true,
    ReadOnly = true,
    RichText = true,
    TextWrapped = false,
    LineNumbers = true,
    AutoScroll = true
})

skibidilog:SetValue("Loaded")
