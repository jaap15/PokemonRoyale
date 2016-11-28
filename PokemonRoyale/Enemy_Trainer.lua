-----------------------------------------------------------------------------------------
--
-- Enemy_Trainer.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------
require("sqlController")
local Pokemon = require("Pokemon")
local pokemon = Pokemon:new( {HP=150} );

local enemy_trainer = {tag = "Enemy_Trainer", E_Pokemans = {}, E_Items = {}, xpos = 542, ypos = 250}

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
	self.trainer.E_Pokemans = {}
	self.arena = display.newImage(bgLocation)
	self.arena.width = display.contentWidth
	self.arena.height = display.contentHeight/2
	self.arena.x = display.contentWidth - (display.contentWidth/2)
	self.arena.y = display.contentHeight - (display.contentHeight/1.33)
	
	self:populatePokemon(trainerInfo)
	
	-- self.currentPokemon = math.random(1, #self.E_Pokemans)
	self.currentPokemon = 1

	self.music = audio.loadStream(musLocation)

	-- self.pokeball = display.newImage("images/pokeball.png")
 --    self.pokeball.width = 48
 --    self.pokeball.height = 48
 --    self.pokeball.x = (display.contentWidth + 300) - display.contentWidth
 --    self.pokeball.y = (display.contentHeight  + 185) - display.contentHeight
 --    self.pokeball:scale(0.8,0.8)

 --    self.pokeball2 = display.newImage("images/pokeball.png")
 --    self.pokeball2.width = 48
 --    self.pokeball2.height = 48
 --    self.pokeball2.x = (display.contentWidth + 260) - display.contentWidth
 --    self.pokeball2.y = (display.contentHeight  + 185) - display.contentHeight
 --    self.pokeball2:scale(0.8,0.8)

 --    self.pokeball3 = display.newImage("images/pokeball.png")
 --    self.pokeball3.width = 48
 --    self.pokeball3.height = 48
 --    self.pokeball3.x = (display.contentWidth + 220) - display.contentWidth
 --    self.pokeball3.y = (display.contentHeight  + 185) - display.contentHeight
 --    self.pokeball3:scale(0.8,0.8)

 --    self.pokeball4 = display.newImage("images/pokeball.png")
 --    self.pokeball4.width = 48
 --    self.pokeball4.height = 48
 --    self.pokeball4.x = (display.contentWidth + 180) - display.contentWidth
 --    self.pokeball4.y = (display.contentHeight  + 185) - display.contentHeight
 --    self.pokeball4:scale(0.8,0.8)

 --    self.pokeball5 = display.newImage("images/pokeball.png")
 --    self.pokeball5.width = 48
 --    self.pokeball5.height = 48
 --    self.pokeball5.x = (display.contentWidth + 140) - display.contentWidth
 --    self.pokeball5.y = (display.contentHeight  + 185) - display.contentHeight
 --    self.pokeball5:scale(0.8,0.8)

 --    self.pokeball6 = display.newImage("images/pokeball.png")
 --    self.pokeball6.width = 48
 --    self.pokeball6.height = 48
 --    self.pokeball6.x = (display.contentWidth + 100) - display.contentWidth
 --    self.pokeball6.y = (display.contentHeight  + 185) - display.contentHeight
 --    self.pokeball6:scale(0.8,0.8)

	
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

	self.trainer.E_Pokemans[1].pokeball.isVisible = true;
	self.trainer.E_Pokemans[2].pokeball.isVisible = true;
	self.trainer.E_Pokemans[3].pokeball.isVisible = true;
	self.trainer.E_Pokemans[4].pokeball.isVisible = true;
	self.trainer.E_Pokemans[5].pokeball.isVisible = true;
	self.trainer.E_Pokemans[6].pokeball.isVisible = true;

	self:moveTrainerOut()
	audio.setVolume(0.5)
	audio.play(self.music)
end

function enemy_trainer:populatePokemon(trainerInfo)
	
	self.trainer.E_Pokemans[1] = pokemon:new({xPos = 542, yPos = 350})
	self.trainer.E_Pokemans[1]:create(trainerInfo.Pokemon1)
	print(trainerInfo.Pokemon1)
	self.trainer.E_Pokemans[1].pokeball = display.newImage("images/pokeball.png")
	self.trainer.E_Pokemans[1].pokeball.width = 48
    self.trainer.E_Pokemans[1].pokeball.height = 48
    self.trainer.E_Pokemans[1].pokeball.x = (display.contentWidth + 300) - display.contentWidth
    self.trainer.E_Pokemans[1].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[1].pokeball:scale(0.8,0.8)
    self.trainer.E_Pokemans[1].pokeball.isVisible = false;

    self.trainer.E_Pokemans[1].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.trainer.E_Pokemans[1].pokeballFainted.width = 48
    self.trainer.E_Pokemans[1].pokeballFainted.height = 48
    self.trainer.E_Pokemans[1].pokeballFainted.x = (display.contentWidth + 300) - display.contentWidth
    self.trainer.E_Pokemans[1].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[1].pokeballFainted:scale(0.8,0.8)
    self.trainer.E_Pokemans[1].pokeballFainted.isVisible = false;
	

	self.trainer.E_Pokemans[2] = pokemon:new({xPos = 542, yPos = 350})
	self.trainer.E_Pokemans[2]:create(trainerInfo.Pokemon2)
	print(trainerInfo.Pokemon2)
	self.trainer.E_Pokemans[2].pokeball = display.newImage("images/pokeball.png")
	self.trainer.E_Pokemans[2].pokeball.width = 48
    self.trainer.E_Pokemans[2].pokeball.height = 48
    self.trainer.E_Pokemans[2].pokeball.x = (display.contentWidth + 260) - display.contentWidth
    self.trainer.E_Pokemans[2].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[2].pokeball:scale(0.8,0.8)
    self.trainer.E_Pokemans[2].pokeball.isVisible = false;

    self.trainer.E_Pokemans[2].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.trainer.E_Pokemans[2].pokeballFainted.width = 48
    self.trainer.E_Pokemans[2].pokeballFainted.height = 48
    self.trainer.E_Pokemans[2].pokeballFainted.x = (display.contentWidth + 260) - display.contentWidth
    self.trainer.E_Pokemans[2].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[2].pokeballFainted:scale(0.8,0.8)
    self.trainer.E_Pokemans[2].pokeballFainted.isVisible = false;


	
	self.trainer.E_Pokemans[3] = pokemon:new({xPos = 542, yPos = 350})
	self.trainer.E_Pokemans[3]:create(trainerInfo.Pokemon3)
	print(trainerInfo.Pokemon3)
	self.trainer.E_Pokemans[3].pokeball = display.newImage("images/pokeball.png")
	self.trainer.E_Pokemans[3].pokeball.width = 48
    self.trainer.E_Pokemans[3].pokeball.height = 48
    self.trainer.E_Pokemans[3].pokeball.x = (display.contentWidth + 220) - display.contentWidth
    self.trainer.E_Pokemans[3].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[3].pokeball:scale(0.8,0.8)
    self.trainer.E_Pokemans[3].pokeball.isVisible = false;

    self.trainer.E_Pokemans[3].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.trainer.E_Pokemans[3].pokeballFainted.width = 48
    self.trainer.E_Pokemans[3].pokeballFainted.height = 48
    self.trainer.E_Pokemans[3].pokeballFainted.x = (display.contentWidth + 220) - display.contentWidth
    self.trainer.E_Pokemans[3].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[3].pokeballFainted:scale(0.8,0.8)
    self.trainer.E_Pokemans[3].pokeballFainted.isVisible = false;


	
	self.trainer.E_Pokemans[4] = pokemon:new({xPos = 542, yPos = 350})
	self.trainer.E_Pokemans[4]:create(trainerInfo.Pokemon4)
	print(trainerInfo.Pokemon4)
	self.trainer.E_Pokemans[4].pokeball = display.newImage("images/pokeball.png")
	self.trainer.E_Pokemans[4].pokeball.width = 48
    self.trainer.E_Pokemans[4].pokeball.height = 48
    self.trainer.E_Pokemans[4].pokeball.x = (display.contentWidth + 180) - display.contentWidth
    self.trainer.E_Pokemans[4].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[4].pokeball:scale(0.8,0.8)
    self.trainer.E_Pokemans[4].pokeball.isVisible = false;

    self.trainer.E_Pokemans[4].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.trainer.E_Pokemans[4].pokeballFainted.width = 48
    self.trainer.E_Pokemans[4].pokeballFainted.height = 48
    self.trainer.E_Pokemans[4].pokeballFainted.x = (display.contentWidth + 180) - display.contentWidth
    self.trainer.E_Pokemans[4].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[4].pokeballFainted:scale(0.8,0.8)
    self.trainer.E_Pokemans[4].pokeballFainted.isVisible = false;

	
	self.trainer.E_Pokemans[5] = pokemon:new({xPos = 542, yPos = 350})
	self.trainer.E_Pokemans[5]:create(trainerInfo.Pokemon5)
	print(trainerInfo.Pokemon5)
	self.trainer.E_Pokemans[5].pokeball = display.newImage("images/pokeball.png")
	self.trainer.E_Pokemans[5].pokeball.width = 48
    self.trainer.E_Pokemans[5].pokeball.height = 48
    self.trainer.E_Pokemans[5].pokeball.x = (display.contentWidth + 140) - display.contentWidth
    self.trainer.E_Pokemans[5].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[5].pokeball:scale(0.8,0.8)
    self.trainer.E_Pokemans[5].pokeball.isVisible = false;

    self.trainer.E_Pokemans[5].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.trainer.E_Pokemans[5].pokeballFainted.width = 48
    self.trainer.E_Pokemans[5].pokeballFainted.height = 48
    self.trainer.E_Pokemans[5].pokeballFainted.x = (display.contentWidth + 140) - display.contentWidth
    self.trainer.E_Pokemans[5].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[5].pokeballFainted:scale(0.8,0.8)
    self.trainer.E_Pokemans[5].pokeballFainted.isVisible = false;

	
	self.trainer.E_Pokemans[6] = pokemon:new({xPos = 542, yPos = 350})
	self.trainer.E_Pokemans[6]:create(trainerInfo.Pokemon6)
	print(trainerInfo.Pokemon6)
	self.trainer.E_Pokemans[6].pokeball = display.newImage("images/pokeball.png")
	self.trainer.E_Pokemans[6].pokeball.width = 48
    self.trainer.E_Pokemans[6].pokeball.height = 48
    self.trainer.E_Pokemans[6].pokeball.x = (display.contentWidth + 100) - display.contentWidth
    self.trainer.E_Pokemans[6].pokeball.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[6].pokeball:scale(0.8,0.8)
    self.trainer.E_Pokemans[6].pokeball.isVisible = false;

    self.trainer.E_Pokemans[6].pokeballFainted = display.newImage("images/pokeballFainted.png")
	self.trainer.E_Pokemans[6].pokeballFainted.width = 48
    self.trainer.E_Pokemans[6].pokeballFainted.height = 48
    self.trainer.E_Pokemans[6].pokeballFainted.x = (display.contentWidth + 100) - display.contentWidth
    self.trainer.E_Pokemans[6].pokeballFainted.y = (display.contentHeight  + 185) - display.contentHeight
    self.trainer.E_Pokemans[6].pokeballFainted:scale(0.8,0.8)
    self.trainer.E_Pokemans[6].pokeballFainted.isVisible = false;
	
end

function enemy_trainer:PokemonFainted(pokemonNumber)
	self.trainer.E_Pokemans[pokemonNumber].pokeball.isVisible = false;
	self.trainer.E_Pokemans[pokemonNumber].pokeballFainted.isVisible = true;
end


function enemy_trainer:audioStop()
	
	audio.stop()
	audio.dispose(self.music)
end

return enemy_trainer