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

  -- ***************************************************
  -- ***************************************************
  -- ***************************************************
  -- Feel free to change any of the daniel added code
  -- Just make sure it doesn't break anything!
  -- ***************************************************
  -- ***************************************************
  -- ***************************************************

  local pokemonInfo;

  pokemonInfo = getPokemonTableInfo(chosePokemon)

  local location = pokemonInfo.imagesLocation.."/select.png"
  self.pokemon = display.newImage(location, 70, 90); --Buffer
  self.pokemon.selectView = display.newImage(location, self.xPos, self.yPos);
  self.pokemon.selectView:scale(3,3)
  -- Used for Pokemon Menu scene
  -- if you think of a better way of doing this then change this code
  self.pokemon.selectViewTN = display.newImage(location, self.xPos, self.yPos); --daniel added code
  self.pokemon.selectViewTN.isVisible = false --daniel added code

  location = pokemonInfo.imagesLocation.."/battle.png"
  self.pokemon.battleView = display.newImage(location, self.xPos, self.yPos);
  self.pokemon.battleView:scale(3,3)
  self.pokemon.pp = self;  -- parent object
  self.pokemon.tag = pokemonInfo.name; -- “Pokemon name”
  self.pokemon.Pid = pokemonInfo.Pid; -- “Pokemon's pokedex #”

  self.pokemon.hp = self.HP -- daniel added code

  -- daniel added code
  self.pokemon.healthBar = display.newRect(0, -45, healthBarLength, 10)
  self.pokemon.healthBar:setFillColor(0,1,0)
  self.pokemon.healthBar.strokeWidth = 1
  self.pokemon.healthBar:setStrokeColor(1,1,1,0.5)

  -- daniel added code
  self.pokemon.damageBar = display.newRect(0, -45, 0, 10)
  self.pokemon.damageBar:setFillColor(1,0,0)

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
end

function Pokemon:setBattleView()
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = true;
end

function Pokemon:HidePokemon()
  self.pokemon.isVisible = false;
  self.pokemon.healthBar.isVisible = false --daniel added code 
  self.pokemon.damageBar.isVisible = false --daniel added code 
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = false;
end

--daniel added code
function Pokemon:returnSelectImage() 
  return self.pokemon.selectViewTN
end

--daniel added code, takes damage
function Pokemon:takeDamage(damageTaken)
  self.pokemon.hp = self.pokemon.hp - damageTaken
  if (self.pokemon.hp < 0) then
    self.pokemon.hp = 0
  end
  self:updateDamageBar()
end

function Pokemon:drawHealthBar()
    self.pokemon.healthBar.x = 535
    self.pokemon.healthBar.y = 545
    self.pokemon.damageBar.x = 535
    self.pokemon.damageBar.y = 545
end

--daniel added code, draws the pokemon health bar
function Pokemon:updateDamageBar()
  self.pokemon.damageBar.x = ((self.pokemon.hp*(((healthBarLength*100)/self.HP)/100)) / 2) + self.pokemon.healthBar.x
  self.pokemon.damageBar.width = (self.HP - self.pokemon.hp) * (((healthBarLength*100)/self.HP)/100)
  print("POKEMON HEALTH : " .. self.pokemon.hp)
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

