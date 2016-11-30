-----------------------------------------------------------------------------------------
--
-- Trainer.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
--
-- Trainer object. Keeps track of all the player's pokemon and inventory. 
-----------------------------------------------------------------------------------------
trainer = {tag = "trainer", Pokemans = {}, Inventory = {}}

-- trainer:new()
--      input: none
--      output: none
--      
--      Constructor method, creates a new trainer object.
function trainer:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- trainer:create()
--      input: none
--      output: none
--      
--      Create method, the trainer has a sprite sheet and currentPokemon index
function trainer:create()
	
	-- Creating animation information
	local sheetName = require("images.fightScene.animations.lucasThrow")
	local spriteSheetData = sheetName:getSheet()	
	local battleSheet = graphics.newImageSheet("images/fightScene/animations/lucasThrow.png", spriteSheetData)	
	local sequenceData = sheetName:getSequence()	

	-- Creating sprite shheet and settings properties
	self.player = display.newSprite(battleSheet, sequenceData)
	self.player.x = 190
	self.player.y = 530
	self.player:scale(2,2)
	self.player.isVisible = false;

	-- Current pokemon on the battle field
	self.currentPokemon = 1;
end

-- trainer:throwAnimation()
--      input: none
--      output: none
--      
--      This function plays the animation we loaded in the create function. 
function trainer:throwAnimation()

	-- throw()
	--      input: none
	--      output: none
	--      
	--      Playing the animation	
	local function throw()
		self.player.isVisible = true;
		trainer.player:play()
	    transition.to(trainer.player, {time = 1250, x=542-750})
	end

	-- Delaying the throw animation because we have an initial background animatino to wait for
	timer.performWithDelay(500, throw)	
end

-- trainer:moveTrainerIn()
--      input: none
--      output: none
--      
--      This animation moves the trainer object offScreen when game starts
function trainer:moveTrainerIn()

	-- appear()
	--      input: none
	--      output: none
	--      
	--      This moves the player
	local function appear()
		self.player.isVisible = true;
		self.player:setFrame(1)
	    transition.to(trainer.player, {time = 1250, x=750-542})
	end

	-- Delaying the animation because we have an initial background animatino to wait for
    timer.performWithDelay(500, appear)	
end


return trainer