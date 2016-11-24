require("sqlController");

local Pokemon = {tag="Pokemon", HP=1, xPos=0, yPos=0};
local image

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

  pokemonInfo = getPokemonAttackInfo(self.pokemon.Pid)
  self.pokemon.attack1 = pokemonInfo.attack1;
  self.pokemon.attack2 = pokemonInfo.attack2;
  self.pokemon.attack3 = pokemonInfo.attack3;
  self.pokemon.attack4 = pokemonInfo.attack4;

  self.pokemon.attack1Damage = pokemonInfo.attack1Damage;
  self.pokemon.attack2Damage = pokemonInfo.attack2Damage;
  self.pokemon.attack3Damage = pokemonInfo.attack3Damage;
  self.pokemon.attack4Damage = pokemonInfo.attack4Damage;

  pokemonInfo = getPokemonStatsInfo(self.pokemon.Pid)

  self.pokemon.type1 = pokemonInfo.type1;
  self.pokemon.type2 = pokemonInfo.type2;
  self.pokemon.maxHP = pokemonInfo.hp;
  self.pokemon.currentHP = pokemonInfo.hp;
  self.pokemon.attackDamage = pokemonInfo.attackDamage;
  self.pokemon.defense = pokemonInfo.defense;
  self.pokemon.spAttack = pokemonInfo.spAttack;
  self.pokemon.spDefense = pokemonInfo.spDefense;
  self.pokemon.speed = pokemonInfo.speed;

  --Health
  self.pokemon.hGroup = display.newGroup( )
  self.pokemon.hGroup.x = display.pixelWidth - 98
  self.pokemon.hGroup.y = display.pixelHeight/2 - 30
  self.pokemon.healthBar = display.newRect(0,-45,self.pokemon.maxHP, 10)
  self.pokemon.healthBar:setFillColor(000/255,255/255,0/255)
  self.pokemon.healthBar.strokeWidth = 1
  self.pokemon.healthBar:setStrokeColor(255,255,255, .5)
  self.pokemon.hGroup:insert(self.pokemon.healthBar)

  self.pokemon.damageBar = display.newRect(0,-45,0,10)
  self.pokemon.damageBar:setFillColor(255/255, 0/255, 0/255)
  self.pokemon.hGroup:insert(self.pokemon.damageBar)

  self.pokemon.hGroup.isVisible = false;
  self.pokemon.healthBar.isVisible = false;
  self.pokemon.damageBar.isVisible = false;


  self.pokemon.isVisible = false;
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = false;
end

function Pokemon:setSelectionView()
  self.pokemon.battleView.isVisible = false;
  self.pokemon.selectView.isVisible = true;
  self.pokemon.healthBar.isVisible = false;
  self.pokemon.damageBar.isVisible = false;
  self.pokemon.hGroup.isVisible = false;
end

function Pokemon:setEnemySelectionView()
  self.pokemon.battleView.isVisible = false;
  self.pokemon.selectView.isVisible = true;
  self.pokemon.hGroup.isVisible = true;
  self.pokemon.healthBar.isVisible = true;
  self.pokemon.damageBar.isVisible = true;
end

function Pokemon:setBattleView()
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = true;
  self.pokemon.hGroup.isVisible = true;
  self.pokemon.healthBar.isVisible = true;
  self.pokemon.damageBar.isVisible = true;
end

function Pokemon:HidePokemon()
  self.pokemon.isVisible = false;
  self.pokemon.selectView.isVisible = false;
  self.pokemon.battleView.isVisible = false;
  self.pokemon.healthBar.isVisible = false;
  self.pokemon.damageBar.isVisible = false;
  self.pokemon.hGroup.isVisible = false;
end

function Pokemon:returnSelectImage()
  return self.pokemon.selectViewTN
end

function Pokemon:setHealthBarPos(xP,yP)

  self.pokemon.hGroup.x = xP
  self.pokemon.hGroup.y = yP
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

function Pokemon:updateDamageBar()
    self.pokemon.damageBar.x = self.pokemon.currentHP/2
    self.pokemon.damageBar.width = self.pokemon.maxHP - self.pokemon.currentHP
end

function Pokemon:damageCharacter(damageTaken)
  if(damageTaken >= self.pokemon.currentHP) then
    self.pokemon.currentHP = 0
    self:updateDamageBar();
  elseif(self.pokemon.currentHP > 0) then
    self.pokemon.currentHP = self.pokemon.currentHP - damageTaken
    self:updateDamageBar();
  end
  print("currentHP: " .. self.pokemon.currentHP)
end



return Pokemon

