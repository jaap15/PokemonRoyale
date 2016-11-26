trainer = {tag = "trainer", Pokemans = {}, Inventory = {}}

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
	
	local function throwAnimation()
		trainer.player:play()
        transition.to(trainer.player, {time = 1250, x=542-750})
    end
    timer.performWithDelay(1500, throwAnimation)
end

function trainer:createPokemonTable(pokemon, numChoice)
	
	self.Pokemans[numChoice] = pokemon
	
	print(self.Pokemans[numChoice])
end

function trainer:switchPokemon(numChoice)
	
	
end

function trainer:addItemtoInventory(item, quantity)

	
end

return trainer