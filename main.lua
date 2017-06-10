--
--bork
--

Timer = require "hump.timer"

function love.load()
	borkSounds = {}
	nextBork = 1
	for i = 1, 8 do
		borkSounds[i] = love.audio.newSource("bork.ogg")
	end
	noteTable = {
		a = 0,
		w = 1,
		s = 2,
		e = 3,
		d = 4,
		f = 5,
		t = 6,
		g = 7,
		y = 8,
		h = 9,
		u = 10,
		j = 11,
		k = 12
	}
	love.graphics.setBackgroundColor(0xff, 0xff, 0xff)
	gabe = {
		img = love.graphics.newImage("gabe.jpg"),
		scale = 1
	}
end

function love.update(dt)
	Timer.update(dt)
end

function love.draw()
	love.graphics.draw(gabe.img,
		love.graphics.getWidth()/2 - gabe.scale*gabe.img:getWidth()/2,
		love.graphics.getHeight()/2 - gabe.scale*gabe.img:getHeight()/2,
		0, gabe.scale)
end

function love.keypressed(key)
	if key == "escape" then love.event.quit() end
	if not noteTable[key] then return end
	local offset = 0
	if love.keyboard.isDown("lshift") then
		offset = -12
	elseif love.keyboard.isDown("lctrl") then
		offset = 12
	end
	Timer.tween(0.05, gabe, { scale = 1.25 }, 'in-out-quad',
		function() Timer.tween(0.05, gabe, { scale = 1 }) end)
	bork(noteTable[key]+offset)
end

function bork(note)
	if note then
		borkSounds[nextBork]:setPitch(2^(note/12))
		borkSounds[nextBork]:stop()
		borkSounds[nextBork]:play()
		nextBork = nextBork % #borkSounds + 1
	end
end
