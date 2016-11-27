require("sqlController");

local Pokemon = {tag="Pokemon", HP=100, xPos=0, yPos=0};
local image
local healthBarLength = 220

local superEffective = 1.5;
local notVeryEffective = 0.5;
local noEffect = 0;

local superEffectiveSound = audio.loadStream("sounds/superEffective.wav")
local notVeryEffectiveSound = audio.loadStream("sounds/NotVeryEffective.wav")
local normalEffectiveSound = audio.loadStream("sounds/normalEffective.wav")

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
  self.pokemon.tag = pokemonInfo.name:gsub("^%l", string.upper); -- “Pokemon name” converts 1st character to uppercase
  self.pokemon.Pid = pokemonInfo.Pid; -- “Pokemon's pokedex #”
  self.pokemon.imagesLocation = pokemonInfo.imagesLocation

  self.pokemon.status = "healthy"

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

  self.pokemon.attack1Type = pokemonInfo.attack1Type;
  self.pokemon.attack2Type = pokemonInfo.attack2Type;
  self.pokemon.attack3Type = pokemonInfo.attack3Type;
  self.pokemon.attack4Type = pokemonInfo.attack4Type;

  pokemonInfo = getPokemonStatsInfo(self.pokemon.Pid)

  self.pokemon.level = 100;
  self.pokemon.type1 = pokemonInfo.type1;
  self.pokemon.type2 = pokemonInfo.type2;
  self.pokemon.maxHP = pokemonInfo.hp;
  self.pokemon.currentHP = pokemonInfo.hp;
  self.pokemon.attackDamage = pokemonInfo.attackDamage;
  self.pokemon.defense = pokemonInfo.defense;
  self.pokemon.spAttack = pokemonInfo.spAttack;
  self.pokemon.spDefense = pokemonInfo.spDefense;
  self.pokemon.speed = pokemonInfo.speed;

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

function Pokemon:attackEffectMultiplier(attackedType)
  local multiplier = 1;
  local t1 = self.pokemon.type1;  --for shorter if statement condition
  local t2 = self.pokemon.type2;  --for shorter if statement condition

  if attackedType == 'normal' then
    print("attackType is normal")
    if t1 == 'rock' or t2 == 'rock' then
      multiplier = notVeryEffective;
    elseif t1 == 'ghost' or t2 == 'ghost' then
        multiplier = noEffect;
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective;
    end
  elseif attackedType == 'fire' then
    print("attackType is fire")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = notVeryEffective;
    elseif t1 == 'water' or t2 == 'water' then
        multiplier = notVeryEffective;  
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = superEffective; 
    elseif t1 == 'ice' or t2 == 'ice' then
        multiplier = superEffective; 
    elseif t1 == 'bug' or t2 == 'bug' then
        multiplier = superEffective; 
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = notVeryEffective;
    elseif t1 == 'dragon' or t2 == 'dragon' then
        multiplier = notVeryEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = superEffective; 
    end
  elseif attackedType == 'water' then
    print("attackType is water")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = superEffective;
    elseif t1 == 'water' or t2 == 'water' then
        multiplier = notVeryEffective; 
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = notVeryEffective; 
    elseif t1 == 'ground' or t2 == 'ground' then
        multiplier = superEffective; 
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = superEffective;
    elseif t1 == 'dragon' or t2 == 'dragon' then
        multiplier = notVeryEffective;
    end
  elseif attackedType == 'electr' then
    print("attackType is electr")
    if t1 == 'water' or t2 == 'water' then
      multiplier = superEffective;
    elseif t1 == 'electr' or t2 == 'electr' then
        multiplier = notVeryEffective; 
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = notVeryEffective; 
    elseif t1 == 'ground' or t2 == 'ground' then
        multiplier = noEffect; 
    elseif t1 == 'flying' or t2 == 'flying' then
        multiplier = superEffective; 
    elseif t1 == 'dragon' or t2 == 'dragon' then
        multiplier = notVeryEffective;
    end
  elseif attackedType == 'grass' then
    print("attackType is grass")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = notVeryEffective;
    elseif t1 == 'water' or t2 == 'water' then
        multiplier = superEffective; 
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = notVeryEffective; 
    elseif t1 == 'poison' or t2 == 'poison' then
        multiplier = notVeryEffective; 
    elseif t1 == 'ground' or t2 == 'ground' then
        multiplier = superEffective; 
    elseif t1 == 'flying' or t2 == 'flying' then
        multiplier = notVeryEffective; 
    elseif t1 == 'bug' or t2 == 'bug' then
        multiplier = notVeryEffective; 
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = superEffective; 
    elseif t1 == 'dragon' or t2 == 'dragon' then
        multiplier = notVeryEffective;         
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective;
    end
  elseif attackedType == 'ice' then
    print("attackType is ice")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = notVeryEffective;
    elseif t1 == 'water' or t2 == 'water' then
        multiplier = notVeryEffective; 
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = superEffective; 
    elseif t1 == 'ice' or t2 == 'ice' then
        multiplier = notVeryEffective; 
    elseif t1 == 'ground' or t2 == 'ground' then
        multiplier = superEffective; 
    elseif t1 == 'flying' or t2 == 'flying' then
        multiplier = superEffective;
    elseif t1 == 'dragon' or t2 == 'dragon' then
        multiplier = superEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective; 
    end
  elseif attackedType == 'fighting' then
    print("attackType is fighting")
    if t1 == 'normal' or t2 == 'normal' then
      multiplier = superEffective;
    elseif t1 == 'ice' or t2 == 'ice' then
        multiplier = superEffective; 
    elseif t1 == 'poison' or t2 == 'poison' then
        multiplier = notVeryEffective; 
    elseif t1 == 'flying' or t2 == 'flying' then
        multiplier = notVeryEffective; 
    elseif t1 == 'psychc' or t2 == 'psychc' then
        multiplier = notVeryEffective; 
    elseif t1 == 'bug' or t2 == 'bug' then
        multiplier = notVeryEffective; 
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = superEffective; 
    elseif t1 == 'ghost' or t2 == 'ghost' then
        multiplier = noEffect; 
    elseif t1 == 'dark' or t2 == 'dark' then
        multiplier = superEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = superEffective; 
    elseif t1 == 'fairy' or t2 == 'fairy' then
        multiplier = notVeryEffective; 
    end
  elseif attackedType == 'poison' then
    print("attackType is poison")
    if t1 == 'grass' or t2 == 'grass' then
      multiplier = superEffective;
    elseif t1 == 'poison' or t2 == 'poison' then
        multiplier = notVeryEffective; 
    elseif t1 == 'ground' or t2 == 'ground' then
        multiplier = notVeryEffective; 
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = notVeryEffective; 
    elseif t1 == 'ghost' or t2 == 'ghost' then
        multiplier = notVeryEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = noEffect; 
    elseif t1 == 'fairy' or t2 == 'fairy' then
        multiplier = superEffective;
    end
  elseif attackedType == 'ground' then
    print("attackType is ground")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = superEffective;
    elseif t1 == 'electr' or t2 == 'electr' then
        multiplier = superEffective; 
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = notVeryEffective; 
    elseif t1 == 'poison' or t2 == 'poison' then
        multiplier = superEffective; 
    elseif t1 == 'flying' or t2 == 'flying' then
        multiplier = noEffect; 
    elseif t1 == 'bug' or t2 == 'bug' then
        multiplier = notVeryEffective; 
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = superEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = superEffective; 
    end
  elseif attackedType == 'flying' then
    print("attackType is flying")
    if t1 == 'electr' or t2 == 'electr' then
      multiplier = notVeryEffective;
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = superEffective; 
    elseif t1 == 'fighting' or t2 == 'fighting' then
        multiplier = superEffective; 
    elseif t1 == 'bug' or t2 == 'bug' then
        multiplier = superEffective; 
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = notVeryEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective; 
    end
  elseif attackedType == 'psychc' then
    print("attackType is psychc")
    if t1 == 'fighting' or t2 == 'fighting' then
      multiplier = superEffective;
    elseif t1 == 'poison' or t2 == 'poison' then
        multiplier = superEffective; 
    elseif t1 == 'psychc' or t2 == 'psychc' then
        multiplier = notVeryEffective; 
    elseif t1 == 'dark' or t2 == 'dark' then
        multiplier = noEffect; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective; 
    end
  elseif attackedType == 'bug' then
    print("attackType is bug")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = notVeryEffective;
    elseif t1 == 'grass' or t2 == 'grass' then
        multiplier = superEffective; 
    elseif t1 == 'fighting' or t2 == 'fighting' then
        multiplier = notVeryEffective; 
    elseif t1 == 'poison' or t2 == 'poison' then
        multiplier = notVeryEffective; 
    elseif t1 == 'flying' or t2 == 'flying' then
        multiplier = notVeryEffective; 
    elseif t1 == 'psychc' or t2 == 'psychc' then
        multiplier = superEffective; 
    elseif t1 == 'ghost' or t2 == 'ghost' then
        multiplier = notVeryEffective; 
    elseif t1 == 'dark' or t2 == 'dark' then
        multiplier = superEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective; 
    elseif t1 == 'fairy' or t2 == 'fairy' then
        multiplier = notVeryEffective; 
    end
  elseif attackedType == 'rock' then
    print("attackType is rock")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = superEffective;
    elseif t1 == 'ice' or t2 == 'ice' then
        multiplier = superEffective; 
    elseif t1 == 'fighting' or t2 == 'fighting' then
        multiplier = notVeryEffective; 
    elseif t1 == 'ground' or t2 == 'ground' then
        multiplier = notVeryEffective; 
    elseif t1 == 'flying' or t2 == 'flying' then
        multiplier = superEffective; 
    elseif t1 == 'bug' or t2 == 'bug' then
        multiplier = superEffective; 
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective; 
    end
  elseif attackedType == 'ghost' then
    print("attackType is ghost")
    if t1 == 'normal' or t2 == 'normal' then
      multiplier = noEffect;
    elseif t1 == 'psychc' or t2 == 'psychc' then
        multiplier = superEffective; 
    elseif t1 == 'ghost' or t2 == 'ghost' then
        multiplier = superEffective; 
    elseif t1 == 'dark' or t2 == 'dark' then
        multiplier = notVeryEffective;
    end 
  elseif attackedType == 'dragon' then
    print("attackType is dragon")
    if t1 == 'dragon' or t2 == 'dragon' then
      multiplier = superEffective;
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective; 
    elseif t1 == 'fairy' or t2 == 'fairy' then
        multiplier = noEffect; 
    end
  elseif attackedType == 'dark' then
    print("attackType is dark")
    if t1 == 'fighting' or t2 == 'fighting' then
      multiplier = notVeryEffective;
    elseif t1 == 'psychc' or t2 == 'psychc' then
        multiplier = superEffective;
    elseif t1 == 'ghost' or t2 == 'ghost' then
        multiplier = superEffective;
    elseif t1 == 'dark' or t2 == 'dark' then
        multiplier = notVeryEffective;
    elseif t1 == 'fairy' or t2 == 'fairy' then
        multiplier = notVeryEffective;
    end
  elseif attackedType == 'steel' then
    print("attackType is steel")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = notVeryEffective;
    elseif t1 == 'water' or t2 == 'water' then
        multiplier = notVeryEffective;
    elseif t1 == 'electr' or t2 == 'electr' then
        multiplier = notVeryEffective;
    elseif t1 == 'ice' or t2 == 'ice' then
        multiplier = superEffective;
    elseif t1 == 'rock' or t2 == 'rock' then
        multiplier = superEffective;
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective;
    elseif t1 == 'fairy' or t2 == 'fairy' then
        multiplier = superEffective;
    end
  elseif attackedType == 'fairy' then
    print("attackType is fairy")
    if t1 == 'fire' or t2 == 'fire' then
      multiplier = notVeryEffective;
    elseif t1 == 'fighting' or t2 == 'fighting' then
        multiplier = superEffective;
    elseif t1 == 'poison' or t2 == 'poison' then
        multiplier = notVeryEffective;
    elseif t1 == 'dragon' or t2 == 'dragon' then
        multiplier = superEffective;
    elseif t1 == 'dark' or t2 == 'dark' then
        multiplier = superEffective;
    elseif t1 == 'steel' or t2 == 'steel' then
        multiplier = notVeryEffective;
    end
  else
    print("Unable to determine the attacks type!")
  end
  return multiplier;

end

function Pokemon:takeDamage(damageTaken, damageTakenType)
  local multiplier = self:attackEffectMultiplier(damageTakenType);
  damageTaken = damageTaken * multiplier;
  self.pokemon.currentHP = self.pokemon.currentHP - (damageTaken*0.5)
  if (self.pokemon.currentHP < 0) then
    self.pokemon.currentHP = 0
    self.pokemon.status = "fainted"
    --print(self.pokemon.tag .. " has " .. self.pokemon.status)
  end

  if multiplier == superEffective then
    audio.play(superEffectiveSound, {loops = 0})
  elseif multiplier == notVeryEffective then
    audio.play(notVeryEffectiveSound, {loops = 0})
  elseif multiplier == noEffect then
    print("No effect sound so nothing is played")
  else
    audio.play(normalEffectiveSound, {loops = 0})
  end

  self:updateDamageBar()
end

function Pokemon:useItem(healthValue)
  if (self.pokemon.status ~= "fainted") then
    self.pokemon.currentHP = self.pokemon.currentHP + healthValue
    if (self.pokemon.currentHP > self.pokemon.maxHP) then
      self.pokemon.currentHP =  self.pokemon.maxHP
    end
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
  self.pokemon.damageBar.x = ((self.pokemon.currentHP*(((healthBarLength*100)/self.pokemon.maxHP)/100)) / 2) + self.pokemon.healthBar.x
  self.pokemon.damageBar.width = (self.pokemon.maxHP - self.pokemon.currentHP) * (((healthBarLength*100)/self.pokemon.maxHP)/100)
  self.pokemon.damageBarTN.x = ((self.pokemon.currentHP*(((healthBarLength*100)/self.pokemon.maxHP)/100)) / 2) + self.pokemon.healthBarTN.x
  self.pokemon.damageBarTN.width = (self.pokemon.maxHP - self.pokemon.currentHP) * (((healthBarLength*100)/self.pokemon.maxHP)/100)
end


return Pokemon

