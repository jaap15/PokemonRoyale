require "sqlite3"
local sql;
local path = system.pathForFile("Database.db", system.ResourceDirectory)
print("The path is "..path)
local db = sqlite3.open(path)

--Handle the applicationExit event to close the db
local function onSystemEvent(event)
    if(event.type == "applicationExit") then
        db:close()
    end
end

Runtime:addEventListener("system", onSystemEvent)

function getPokemonTableInfo(chosePokemon)
	local pokemonInfo;

	if tonumber(chosePokemon) then
		--Number passed as parameter
		sql = "SELECT * FROM pokemons WHERE Pid == " .. chosePokemon
		print("The passed parameter number: "..chosePokemon)
	else
		--Name passed as parameter
		sql = 'SELECT * FROM pokemons WHERE name == "' .. chosePokemon .. '"'
		print("The passed parameter string: "..chosePokemon)
	end

	for row in db:nrows(sql) do
		pokemonInfo = row;
		print(row.id.. ", "..row.Pid..", "..row.name..", "..row.imagesLocation)
	end

	return pokemonInfo;

end