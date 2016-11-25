require("sqlController");

local Pokemon = {tag="Pokemon", HP=100, xPos=0, yPos=0};
local image
local healthBarLength = 220

function Pokemon:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Pokemon:create(chosePokemon)

  local pokemonInfo;

  pokemonInfo = getPokemonTableInfo(chosePokemon)

  local location = pokemonInfo.imagesLocation.."/select.png"
  self.pokemon = display.newImage(location, 70, 90); --Buffer
  self.pokemon.selectView = display.newImage(location, self.xPos, self.yPos);
  self.pokemon.selectView:scale(3,3)
  -- Used for Pokemon Menu scene
  -- if you think of a better way of doing this then change this code
  self.pokemon.selectViewTN = display.newImage(location, self.xPos, self.yPos);
  self.pokemon.selectViewTN.isVisible = false

  location = pokemonInfo.imagesLocation.."/battle.png"
  self.pokemon.battleView = display.newImage(location, self.xPos, self.yPos);
  self.pokemon.battleView:scale(3,3)
  self.pokemon.pp = self;  -- parent object
  self.pokemon.tag = pokemonInfo.name; -- “Pokemon name”
  self.pokemon.Pid = pokemonInfo.Pid; -- “Pokemon's pokedex #”

  self.pokemon.hp = self.HP

  self.pokemon.healthBar = display.newRect(0, -45, healthBarLength, 10)
  self.pokemon.healthBar:setFillColor(0,1,0)
  self.pokemon.healthBar.strokeWidth = 1
  self.pokemon.healthBar:setStrokeColor(1,1,1,0.5)
  self.pokemon.healthBarTN = display.newRect(0, -45, healthBarLength, 10)
  self.pokemon.healthBarTN:setFillColor(0,1,0)
  self.pokemon.healthBarTN.strokeWidth = 1
  self.pokemon.healthBarTN:setStrokeColor(1,1,1,0.5)
  self.pokemon.healthBarTN.isVisible = false

  self.pokemon.damageBar = display.newRect(0, -45, 0, 10)
  self.pokemon.damageBar:setFillColor(1,0,0)
  self.pokemon.damageBarTN = display.newRect(0, -45, 0, 10)
  self.pokemon.damageBarTN:setFillColor(1,0,0)
  self.pokemon.damageBarTN.isVisible = false

  pokemonInfo = getPokemonAttackInfo(self.pokemon.Pid)
  self.pokemon.attack1 = pokemonInfo.attack1;
  self.pokemon.attack2 = pokemonInfo.attack2;
  self.pokemon.attack3 = pokemonInfo.attack3;
  self.pokemon.attack4 = pokemonInfo.attack4;

  self.pokemon.attack1Damage = pokemonInfo.attack1Damage;
  self.pokemon.attack2Damage = pokemonInfo.attack2Damage;
  self.pokemon.attack3Damage = pokemonInfo.attack3Damage;
  self.pokemon.attack4Damage = pokemonInfo.attack4Damage;

  self.pokemon.isVisible = false;
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = false;
end

function Pokemon:setSelectionView()
  self.pokemon.battleView.isVisible = false;
  self.pokemon.selectView.isVisible = true;
  self.pokemon.healthBar.isVisible = true
  self.pokemon.damageBar.isVisible = true
end

function Pokemon:setBattleView()
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = true;
  self.pokemon.healthBar.isVisible = true
  self.pokemon.damageBar.isVisible = true
end

function Pokemon:HidePokemon()
  self.pokemon.isVisible = false;
  self.pokemon.healthBar.isVisible = false
  self.pokemon.damageBar.isVisible = false 
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = false;
end

function Pokemon:returnSelectImage() 
  return self.pokemon.selectViewTN
end

function Pokemon:returnHealthStatus() 
  return self.pokemon.healthBarTN, self.pokemon.damageBarTN
end

function Pokemon:takeDamage(damageTaken)
  self.pokemon.hp = self.pokemon.hp - damageTaken
  if (self.pokemon.hp < 0) then
    self.pokemon.hp = 0
  end
  self:updateDamageBar()
end

function Pokemon:drawHealthBar(index)
  if (index == "player") then
    self.pokemon.healthBar.x = display.contentWidth - 200
    self.pokemon.healthBar.y = display.contentHeight/2 - 100
    self.pokemon.damageBar.x = display.contentWidth - 200
    self.pokemon.damageBar.y = display.contentHeight/2 - 100
    self.pokemon.healthBar.isVisible = false
    self.pokemon.damageBar.isVisible = false
  elseif (index == "enemy") then
    self.pokemon.healthBar.x = (display.contentWidth + 200) - display.contentWidth
    self.pokemon.healthBar.y = (display.contentHeight  + 100) - display.contentHeight
    self.pokemon.damageBar.x = (display.contentWidth + 200) - display.contentWidth
    self.pokemon.damageBar.y = (display.contentHeight  + 100) - display.contentHeight
    self.pokemon.healthBar.isVisible = false
    self.pokemon.damageBar.isVisible = false
  end
end

function Pokemon:updateDamageBar()
  self.pokemon.damageBar.x = ((self.pokemon.hp*(((healthBarLength*100)/self.HP)/100)) / 2) + self.pokemon.healthBar.x
  self.pokemon.damageBar.width = (self.HP - self.pokemon.hp) * (((healthBarLength*100)/self.HP)/100)
  self.pokemon.damageBarTN.x = ((self.pokemon.hp*(((healthBarLength*100)/self.HP)/100)) / 2) + self.pokemon.healthBarTN.x
  self.pokemon.damageBarTN.width = (self.HP - self.pokemon.hp) * (((healthBarLength*100)/self.HP)/100)
end

function Pokemon:setPos(xP,yP)

  self.xPos = xP;
  self.yPos = yP;
  self.pokemon.x = self.xPos;
  self.pokemon.y = self.yPos;
  self.pokemon.selectView.x = self.xPos;
  self.pokemon.selectView.y = self.yPos;
  self.pokemon.battleView.x = self.xPos;
  self.pokemon.battleView.y = self.yPos;

end


return Pokemon

