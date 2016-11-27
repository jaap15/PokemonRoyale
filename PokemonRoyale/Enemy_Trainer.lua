-----------------------------------------------------------------------------------------
--
-- Enemy_Trainer.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------
require("sqlController")
local pokemon = require("Pokemon")

enemy_trainer = {tag = "Enemy_Trainer", E_Pokemans = {}, E_Items = {}, xpos = 542, ypos = 250}

function enemy_trainer:new(o)
	
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	return o
end

function enemy_trainer:create(trainerChoice)
	
	local trainerInfo = getEtrainerInfo(trainerChoice)
	
	local location = trainerInfo.imagesLocation ..".png"
	local bgLocation = trainerInfo.stageLocation ..".png"
	local musLocation = trainerInfo.musicLocation ..".mp3"
	
	print(trainerInfo.imagesLocation)
	self.trainer = display.newImage(location, self.xpos, self.ypos)
	self.trainer:scale(3,3)
	self.trainer.pp = self
	self.trainer.tag = trainerInfo.Trainer_Name
	self.arena = display.newImage(bgLocation)
	self.arena.width = display.contentWidth
	self.arena.height = display.contentHeight/2
	self.arena.x = display.contentWidth - (display.contentWidth/2)
	self.arena.y = display.contentHeight - (display.contentHeight/1.33)
	
	self:populatePokemon(trainerInfo)
	
	self.currentPokemon = math.random(1, #self.E_Pokemans)
	
	self.music = audio.loadStream(musLocation)
	audio.setVolume(0.5)
	audio.play(self.music)
	
	local function translateTrainer1 ()
        transition.to(self.trainer, {time = 750, x=self.trainer.x+300})
    end
    timer.performWithDelay(1500, translateTrainer1)
end

function enemy_trainer:populatePokemon(trainerInfo)
	
	self.E_Pokemans[1] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[1]:create(trainerInfo.Pokemon1)
	
	self.E_Pokemans[2] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[2]:create(trainerInfo.Pokemon2)
	
	self.E_Pokemans[3] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[3]:create(trainerInfo.Pokemon3)
	
	self.E_Pokemans[4] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[4]:create(trainerInfo.Pokemon4)
	
	self.E_Pokemans[5] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[5]:create(trainerInfo.Pokemon5)
	
	self.E_Pokemans[6] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[6]:create(trainerInfo.Pokemon6)
	
	self.numPokemans = #self.E_Pokemans - 1
	
end

function enemy_trainer:audioStop()
	
	audio.stop()
	audio.dispose(self.music)
end

function enemy_trainer:BattleTurn(pTrainer)
	
	atkChoice = math.random(1, 4)
	
	if(atkChoice == 1) then
		pTrainer.Pokemans[pTrainer.currentPokemon]:takeDamage(self.E_Pokemans[self.currentPokemon].pokemon.attack1Damage, self.E_Pokemans[self.currentPokemon].pokemon.attack1Type)
	
	elseif(atkChoice == 2) then
		pTrainer.Pokemans[pTrainer.currentPokemon]:takeDamage(self.E_Pokemans[self.currentPokemon].pokemon.attack2Damage, self.E_Pokemans[self.currentPokemon].pokemon.attack2Type)
	
	elseif(atkChoice == 3) then
		pTrainer.Pokemans[pTrainer.currentPokemon]:takeDamage(self.E_Pokemans[self.currentPokemon].pokemon.attack3Damage, self.E_Pokemans[self.currentPokemon].pokemon.attack3Type)
	
	elseif(atkChoice == 4) then
		pTrainer.Pokemans[pTrainer.currentPokemon]:takeDamage(self.E_Pokemans[self.currentPokemon].pokemon.attack4Damage, self.E_Pokemans[self.currentPokemon].pokemon.attack4Type)
	
	end
end

function enemy_trainer:pickNewPokemon()
	
	table.remove(self.E_Pokemans, self.currentPokemon)
	self.numPokemans = self.numPokemans - 1
	print(self.numPokemans)
	
	pokeChoice = math.random(1, #self.E_Pokemans)
	
	self.currentPokemon = pokeChoice
end

return enemy_trainer