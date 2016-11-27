trainer = {tag = "trainer", Pokemans = {}, Inventory = {}}

local menuClick = audio.loadStream("sounds/menuButtonClick.mp3")

function trainer:new(o)
	
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	return o
end

function trainer:create()
	
	local sheetName = require("images.fightScene.animations.lucasThrow")
	local spriteSheetData = sheetName:getSheet()
	
	local battleSheet = graphics.newImageSheet("images/fightScene/animations/lucasThrow.png", spriteSheetData)
	
	local sequenceData = sheetName:getSequence()
	
	self.player = display.newSprite(battleSheet, sequenceData)
	self.player.x = 190
	self.player.y = 530
	self.player:scale(2,2)
	self.currentPokemon = 1
	self.numfaintedPokemon = 0
	
	local function throwAnimation()
		trainer.player:play()
        transition.to(trainer.player, {time = 1250, x=542-750})
    end
    timer.performWithDelay(1500, throwAnimation)
	
end

function trainer:addItemtoInventory(item)

	
end

return trainer