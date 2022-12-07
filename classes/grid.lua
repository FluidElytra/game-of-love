Grid = _object:extend()

local update_trigger = true
local ioffset = {-1,0,1,1,1,0,-1,-1}
local joffset = {-1,-1,-1,0,1,1,1,0}
local iteration = 0

function Grid:new(N_x, N_y)
	-- create a grid
	self.N_x = N_x
	self.N_y = N_y
	self.x = {}
	self.y = {}
	self.state = {}
	self.neighbor = {}
	for i = 0, N_x do
		self.x[i] = {}
		self.y[i] = {}
		self.state[i] = {}
		self.neighbor[i] = {}
		for j = 0, N_y do
			self.x[i][j] = i
			self.y[i][j] = j
			self.state[i][j] = 0
			self.neighbor[i][j] = 0
		end
	end

	-- compute the grid parameters
	self.dx = _screenx/self.N_x
	self.dy = _screeny/self.N_y

	-- aesthetic
	self.color = _colors.lightgrey
end

function Grid:update()
	-- update loop
	if update_trigger == true then
		-- delay the update so the player can perceive it
		_timer.during(1,
			function()
				update_trigger = false
			end,
			function()
				update_trigger = true
			end)

		-- print iteration
		iteration = iteration + 1
		print(iteration)

		-- scan and apply the rules
		if iteration > 1 then
			-- count the neighbor
			for i = 1, self.N_x-1 do
				for j = 1, self.N_y-1 do
					-- reset the counter for each cell
					self.neighbor[i][j] = 0 
					
					-- count the neighbors
					for k = 1, 8 do
						if self.state[i+ioffset[k]][j+joffset[k]] == 1 then
							self.neighbor[i][j] = self.neighbor[i][j]+1
						end
					end
				end
			end

			-- apply the rules
			for i = 1, self.N_x-1 do
				for j = 1, self.N_y-1 do
					-- rules
					if self.state[i][j] == 1 then-- alive
						if self.neighbor[i][j] == 2 or self.neighbor[i][j] == 3 then
							self.state[i][j] = 1 -- survives
						else
							self.state[i][j] = 0 -- dies
						end
					else -- dead
						if self.neighbor[i][j] == 3 then
							self.state[i][j] = 1 -- birth
						end
					end
				end
			end
		end
	end
end

function Grid:init_neighbor()
	-- initialize the neighbor count
	for i = 1, self.N_x-1 do
		for j = 1, self.N_y-1 do
			-- reset the counter for each cell
			self.neighbor[i][j] = 0 
			-- count the neighbors
			for k = 1, 8 do
				if self.state[i+ioffset[k]][j+joffset[k]] == 1 then
					self.neighbor[i][j] = self.neighbor[i][j]+1
				end
			end
		end
	end
end






function Grid:draw()
	-- draw the grid
	for i = 0, self.N_x do
		for j = 0, self.N_y do
			if self.state[i][j] == 0 then
				love.graphics.setColor(_colors.lightgrey)
				love.graphics.rectangle('line', self.x[i][j]*self.dx, self.y[i][j]*self.dy, self.dx, self.dy)
				love.graphics.setColor(_colors.lightgrey)
				love.graphics.printf(tostring(self.neighbor[i][j]), _cmutypewriter, self.x[i][j]*self.dx, self.y[i][j]*self.dy, self.dx, 'center')
			else
				love.graphics.setColor(_colors.white)
				love.graphics.rectangle('fill', self.x[i][j]*self.dx, self.y[i][j]*self.dy, self.dx, self.dy)
				love.graphics.setColor(_colors.grey)
				love.graphics.printf(tostring(self.neighbor[i][j]), _cmutypewriter, self.x[i][j]*self.dx, self.y[i][j]*self.dy, self.dx, 'center')
			end
		end
	end
end