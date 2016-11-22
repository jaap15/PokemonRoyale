local Pokemon = {tag="Pokemon", HP=1, xPos=0, yPos=0};
local PokemonImageGroup = display.newGroup()

function Pokemon:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Pokemon:create()
  self.pokemon = display.newImage(PokemonImageGroup, "images/p10.png", 70, 90); --Buffer
  self.pokemon.selectView = display.newImage("images/p10.png", self.xPos, self.yPos);
  self.pokemon.battleView = display.newImage("images/b10.png", self.xPos, self.yPos);
  self.pokemon.pp = self;  -- parent object
  self.pokemon.tag = self.tag; -- “Pokemon”
  self.pokemon.isVisible = false;
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

