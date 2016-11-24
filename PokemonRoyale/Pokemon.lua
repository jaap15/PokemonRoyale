require("sqlController");

local Pokemon = {tag="Pokemon", HP=1, xPos=0, yPos=0};

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

