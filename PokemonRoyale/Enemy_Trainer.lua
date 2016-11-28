-----------------------------------------------------------------------------------------
--
-- Enemy_Trainer.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------
require("sqlController")
local Pokemon = require("Pokemon")
local pokemon = Pokemon:new( {HP=150} );

local enemy_trainer = {tag = "Enemy_Trainer", E_Items = {}, xpos = 542, ypos = 250}

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
	self.E_Pokemans = {}
	self.arena = display.newImage(bgLocation)
	self.arena.width = display.contentWidth
	self.arena.height = display.contentHeight/2
	self.arena.x = display.contentWidth - (display.contentWidth/2)
	self.arena.y = display.contentHeight - (display.contentHeight/1.33)

	self.cAttack = {};
	
	self:populatePokemon(trainerInfo)
	
	-- self.currentPokemon = math.random(1, #self.E_Pokemans)
	self.currentPokemon = 1

	self.music = audio.loadStream(musLocation)


	
	self.arena.isVisible = false;
	self.trainer.isVisible = false;

	-- self.pokeball.isVisible = false;
	-- self.pokeball2.isVisible = false;
	-- self.pokeball3.isVisible = false;
	-- self.pokeball4.isVisible = false;
	-- self.pokeball5.isVisible = false;
	-- self.pokeball6.isVisible = false;

end

function enemy_trainer:moveTrainerIn()
	local function translateTrainer1 ()
        transition.to(self.trainer, {time = 750, x=self.trainer.x-300})
    end
    timer.performWithDelay(500, translateTrainer1)
end

function enemy_trainer:moveTrainerOut()
	local function translateTrainer1 ()
        transition.to(self.trainer, {time = 750, x=self.trainer.x+300})
    end
    timer.performWithDelay(500, translateTrainer1)
end

function enemy_trainer:beginBattle()

	self.arena.isVisible = true;
	self.trainer.isVisible = true;

	self.E_Pokemans[1].pokeball.isVisible = true;
	self.E_Pokemans[2].pokeball.isVisible = true;
	self.E_Pokemans[3].pokeball.isVisible = true;
	self.E_Pokemans[4].pokeball.isVisible = true;
	self.E_Pokemans[5].pokeball.isVisible = true;
	self.E_Pokemans[6].pokeball.isVisible = true;

	self:moveTrainerOut()
	audio.setVolume(0.5)
	audio.play(self.music)
end

function enemy_trainer:populatePokemon(trainerInfo)
	
	self.E_Pokemans[1] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[1]:create(trainerInfo.Pokemon1)
	print(trainerInfo.Pokemon1)
	self.E_Pokemans[1].pokeball = display.newImage("images/pokeball.png")
	self.E_Pokemans[1].pokeball.width = 48
    self.E_Pokemans[1].pokeball.height = 48
    self.E_Pokemans[1].pokeball.x = (display.contentWidth + 300) - display.contentWidth
    self.E_Pokemans[1].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[1].pokeball:scale(0.8,0.8)
    self.E_Pokemans[1].pokeball.isVisible = false;

    self.E_Pokemans[1].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.E_Pokemans[1].pokeballFainted.width = 48
    self.E_Pokemans[1].pokeballFainted.height = 48
    self.E_Pokemans[1].pokeballFainted.x = (display.contentWidth + 300) - display.contentWidth
    self.E_Pokemans[1].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[1].pokeballFainted:scale(0.8,0.8)
    self.E_Pokemans[1].pokeballFainted.isVisible = false;
	

	self.E_Pokemans[2] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[2]:create(trainerInfo.Pokemon2)
	print(trainerInfo.Pokemon2)
	self.E_Pokemans[2].pokeball = display.newImage("images/pokeball.png")
	self.E_Pokemans[2].pokeball.width = 48
    self.E_Pokemans[2].pokeball.height = 48
    self.E_Pokemans[2].pokeball.x = (display.contentWidth + 260) - display.contentWidth
    self.E_Pokemans[2].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[2].pokeball:scale(0.8,0.8)
    self.E_Pokemans[2].pokeball.isVisible = false;

    self.E_Pokemans[2].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.E_Pokemans[2].pokeballFainted.width = 48
    self.E_Pokemans[2].pokeballFainted.height = 48
    self.E_Pokemans[2].pokeballFainted.x = (display.contentWidth + 260) - display.contentWidth
    self.E_Pokemans[2].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[2].pokeballFainted:scale(0.8,0.8)
    self.E_Pokemans[2].pokeballFainted.isVisible = false;


	
	self.E_Pokemans[3] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[3]:create(trainerInfo.Pokemon3)
	print(trainerInfo.Pokemon3)
	self.E_Pokemans[3].pokeball = display.newImage("images/pokeball.png")
	self.E_Pokemans[3].pokeball.width = 48
    self.E_Pokemans[3].pokeball.height = 48
    self.E_Pokemans[3].pokeball.x = (display.contentWidth + 220) - display.contentWidth
    self.E_Pokemans[3].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[3].pokeball:scale(0.8,0.8)
    self.E_Pokemans[3].pokeball.isVisible = false;

    self.E_Pokemans[3].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.E_Pokemans[3].pokeballFainted.width = 48
    self.E_Pokemans[3].pokeballFainted.height = 48
    self.E_Pokemans[3].pokeballFainted.x = (display.contentWidth + 220) - display.contentWidth
    self.E_Pokemans[3].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[3].pokeballFainted:scale(0.8,0.8)
    self.E_Pokemans[3].pokeballFainted.isVisible = false;


	
	self.E_Pokemans[4] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[4]:create(trainerInfo.Pokemon4)
	print(trainerInfo.Pokemon4)
	self.E_Pokemans[4].pokeball = display.newImage("images/pokeball.png")
	self.E_Pokemans[4].pokeball.width = 48
    self.E_Pokemans[4].pokeball.height = 48
    self.E_Pokemans[4].pokeball.x = (display.contentWidth + 180) - display.contentWidth
    self.E_Pokemans[4].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[4].pokeball:scale(0.8,0.8)
    self.E_Pokemans[4].pokeball.isVisible = false;

    self.E_Pokemans[4].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.E_Pokemans[4].pokeballFainted.width = 48
    self.E_Pokemans[4].pokeballFainted.height = 48
    self.E_Pokemans[4].pokeballFainted.x = (display.contentWidth + 180) - display.contentWidth
    self.E_Pokemans[4].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[4].pokeballFainted:scale(0.8,0.8)
    self.E_Pokemans[4].pokeballFainted.isVisible = false;

	
	self.E_Pokemans[5] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[5]:create(trainerInfo.Pokemon5)
	print(trainerInfo.Pokemon5)
	self.E_Pokemans[5].pokeball = display.newImage("images/pokeball.png")
	self.E_Pokemans[5].pokeball.width = 48
    self.E_Pokemans[5].pokeball.height = 48
    self.E_Pokemans[5].pokeball.x = (display.contentWidth + 140) - display.contentWidth
    self.E_Pokemans[5].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[5].pokeball:scale(0.8,0.8)
    self.E_Pokemans[5].pokeball.isVisible = false;

    self.E_Pokemans[5].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.E_Pokemans[5].pokeballFainted.width = 48
    self.E_Pokemans[5].pokeballFainted.height = 48
    self.E_Pokemans[5].pokeballFainted.x = (display.contentWidth + 140) - display.contentWidth
    self.E_Pokemans[5].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[5].pokeballFainted:scale(0.8,0.8)
    self.E_Pokemans[5].pokeballFainted.isVisible = false;

	
	self.E_Pokemans[6] = pokemon:new({xPos = 542, yPos = 350})
	self.E_Pokemans[6]:create(trainerInfo.Pokemon6)
	print(trainerInfo.Pokemon6)
	self.E_Pokemans[6].pokeball = display.newImage("images/pokeball.png")
	self.E_Pokemans[6].pokeball.width = 48
    self.E_Pokemans[6].pokeball.height = 48
    self.E_Pokemans[6].pokeball.x = (display.contentWidth + 100) - display.contentWidth
    self.E_Pokemans[6].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[6].pokeball:scale(0.8,0.8)
    self.E_Pokemans[6].pokeball.isVisible = false;

    self.E_Pokemans[6].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.E_Pokemans[6].pokeballFainted.width = 48
    self.E_Pokemans[6].pokeballFainted.height = 48
    self.E_Pokemans[6].pokeballFainted.x = (display.contentWidth + 100) - display.contentWidth
    self.E_Pokemans[6].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.E_Pokemans[6].pokeballFainted:scale(0.8,0.8)
    self.E_Pokemans[6].pokeballFainted.isVisible = false;
	
end

function enemy_trainer:PokemonFainted(pokemonIndex)
	self.E_Pokemans[pokemonIndex].pokeball.isVisible = false;
	self.E_Pokemans[pokemonIndex].pokeballFainted.isVisible = true;
end

function enemy_trainer:generateAttack(pokemonIndex)
	atkChoice = math.random(1, 4)
	
	if(atkChoice == 1) then
		self.cAttack.AttackName = self.E_Pokemans[pokemonIndex].pokemon.attack1
		self.cAttack.AttackDamage = self.E_Pokemans[pokemonIndex].pokemon.attack1Damage
		self.cAttack.AttackType = self.E_Pokemans[pokemonIndex].pokemon.attack1Type
	
	elseif(atkChoice == 2) then
		self.cAttack.AttackName = self.E_Pokemans[pokemonIndex].pokemon.attack2
		self.cAttack.AttackDamage = self.E_Pokemans[pokemonIndex].pokemon.attack2Damage
		self.cAttack.AttackType = self.E_Pokemans[pokemonIndex].pokemon.attack2Type
	
	elseif(atkChoice == 3) then
		self.cAttack.AttackName = self.E_Pokemans[pokemonIndex].pokemon.attack3
		self.cAttack.AttackDamage = self.E_Pokemans[pokemonIndex].pokemon.attack3Damage
		self.cAttack.AttackType = self.E_Pokemans[pokemonIndex].pokemon.attack3Type
	
	elseif(atkChoice == 4) then
		self.cAttack.AttackName = self.E_Pokemans[pokemonIndex].pokemon.attack4
		self.cAttack.AttackDamage = self.E_Pokemans[pokemonIndex].pokemon.attack4Damage
		self.cAttack.AttackType = self.E_Pokemans[pokemonIndex].pokemon.attack4Type
	
	end

	print("Enemy Attack generated: "..self.cAttack.AttackName..", "..self.cAttack.AttackDamage..", "..self.cAttack.AttackType)
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

function enemy_trainer:audioStop()
	
	audio.stop()
	audio.dispose(self.music)
end

return enemy_trainer