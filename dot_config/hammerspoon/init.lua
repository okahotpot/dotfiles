-- Flash a red border around the focused window
local focusBorder
local function flashFocusBorder()
	local win = hs.window.frontmostWindow() or hs.window.focusedWindow()
	if not win then
		return
	end

	local f = win:frame()
	local borderWidth = 20 -- thickness of the border; tweak as desired

	-- Delete any existing border first
	if focusBorder then
		focusBorder:delete()
		focusBorder = nil
	end

	-- Draw a rectangle slightly larger than the window
	focusBorder = hs.drawing.rectangle(
		hs.geometry.rect(f.x - borderWidth / 2, f.y - borderWidth / 2, f.w + borderWidth, f.h + borderWidth)
	)
	focusBorder:setStroke(true)
	focusBorder:setStrokeWidth(borderWidth)
	focusBorder:setStrokeColor({ red = 1, green = 0, blue = 0, alpha = 0.95 })
	focusBorder:setFill(false)
	focusBorder:setLevel(hs.drawing.windowLevels.overlay)
	focusBorder:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
	focusBorder:show()

	-- Fade and clean up
	hs.timer.doAfter(0.15, function()
		if focusBorder then
			focusBorder:setAlpha(0.4)
		end
		hs.timer.doAfter(0.10, function()
			if focusBorder then
				focusBorder:delete()
				focusBorder = nil
			end
		end)
	end)
end

-- Toggle focus: if mouse is on left, click right; if on right, click left
local function toggleSideClick()
	-- Get screen (focused window or current mouse screen)
	local screen = hs.window.focusedWindow() and hs.window.focusedWindow():screen() or hs.mouse.getCurrentScreen()
	if not screen then
		hs.alert.show("No screen detected")
		return
	end

	local f = screen:frame()
	local mouse = hs.mouse.absolutePosition()
	local cx = f.x + f.w / 2
	local cy = f.y + f.h / 2

	-- Determine which side the mouse is on
	local side = (mouse.x < cx) and "left" or "right"
	local target

	if side == "left" then
		-- Mouse is on left → click center of right half
		target = { x = f.x + (3 * f.w / 4), y = cy }
	else
		-- Mouse is on right → click center of left half
		target = { x = f.x + (f.w / 4), y = cy }
	end

	-- Move mouse & click
	hs.mouse.absolutePosition(target)
	hs.timer.usleep(20 * 1000)
	hs.eventtap.leftClick(target)

	-- inside toggleSideClick(), after you compute which side to click:
	local targetSide = (side == "left") and "right" or "left"

	-- after the click/focus settles:
	hs.timer.doAfter(0.05, function()
		local win = hs.window.frontmostWindow() or hs.window.focusedWindow()
		if not win then
			hs.alert.show("No window focused", 0.9)
		end
		flashFocusBorder()
	end)
end

-- Hotkey: ⌥⌃⇧0 toggles side focus
hs.hotkey.bind({ "alt", "ctrl", "shift" }, "0", toggleSideClick)

-- ⌘ + \  => select area, save to ~/Pictures/Snippets, open in Preview with Markup
hs.hotkey.bind({ "cmd" }, "\\", function()
	local dir = os.getenv("HOME") .. "/Pictures/Snippets"
	hs.execute(string.format([[mkdir -p "%s"]], dir))

	local filename = os.date("snippet-%Y%m%d-%H%M%S.png")
	local path = string.format("%s/%s", dir, filename)

	-- Interactive selection (-i), selection mode (-s), no shutter sound (-x)
	local t = hs.task.new("/usr/sbin/screencapture", function(exitCode, _, _)
		if exitCode == 0 then
			-- Open in Preview
			hs.task.new("/usr/bin/open", nil, { "-a", "Preview.app", path }):start()

			-- Give Preview a moment, then show Markup (Shift+Cmd+A)
			hs.timer.doAfter(0.5, function()
				local app = hs.appfinder.appFromName("Preview")
				if app then
					app:activate()
					hs.eventtap.keyStroke({ "shift", "cmd" }, "A", 0, app)
				end
			end)
		else
			hs.alert.show("Screenshot canceled.")
		end
	end, { "-i", "-s", "-x", path })

	t:start()
end)

-- Arrow keys with Option + hjkl
-- Option + h → Left arrow
hs.hotkey.bind({ "alt" }, "h", function()
	hs.eventtap.keyStroke({}, "left")
end)

-- Option + j → Down arrow
hs.hotkey.bind({ "alt" }, "j", function()
	hs.eventtap.keyStroke({}, "down")
end)

-- Option + k → Up arrow
hs.hotkey.bind({ "alt" }, "k", function()
	hs.eventtap.keyStroke({}, "up")
end)

-- Option + l → Right arrow
hs.hotkey.bind({ "alt" }, "l", function()
	hs.eventtap.keyStroke({}, "right")
end)
