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


return Pokemon

