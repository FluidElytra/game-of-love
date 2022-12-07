_object = require("lib/classic")
_vector = require("lib/hump.vector")
_timer = require("lib/hump.timer")
_colors = require("assets/colors")

require("classes/grid")

_screenx = 1000
_screeny = 1000

love.graphics.setBackgroundColor( _colors.grey )
love.window.setMode(_screenx, _screeny)

function love.load()
	grid = Grid(20,20)
	_cmutypewriter = love.graphics.newFont("assets/fonts/computer-modern/cmuntb.ttf", grid.dx*0.8)
	-- frog
	grid.state[9][10] = 1
	grid.state[10][10] = 1
	grid.state[11][10] = 1
	grid.state[11][9] = 1
	grid.state[10][9] = 1
	grid.state[12][9] = 1

	-- block
	-- grid.state[9][10] = 1
	-- grid.state[10][10] = 1
	-- grid.state[10][9] = 1
	-- grid.state[9][9] = 1

	-- blinker
	-- grid.state[9][10] = 1
	-- grid.state[9][11] = 1
	-- grid.state[9][12] = 1


	grid:init_neighbor()
end

function love.update(dt)
	_timer.update(dt)
	grid:update()
end

function love.draw(dt)
	-- draw the grid
	grid:draw()
end


