trainer = {tag = "trainer", Pokemans = {}, Inventory = {}}

function trainer:new(o)
	
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	return o
end

function trainer:create()
	
	--self.shape = 
end

function trainer:createPokemonTable(pokemon, numChoice)
	
	self.Pokemans[numChoice] = pokemon
	
	print(self.Pokemans[numChoice])
end

function trainer:switchPokemon(numChoice)
	
	
end

function trainer:addItemtoInventory(item, quantity)

	
end

return trainer