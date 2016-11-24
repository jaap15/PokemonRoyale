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
		-- print("The passed parameter number: "..chosePokemon)
	else
		--Name passed as parameter
		sql = 'SELECT * FROM pokemons WHERE name == "' .. chosePokemon .. '"'
		-- print("The passed parameter string: "..chosePokemon)
	end

	for row in db:nrows(sql) do
		pokemonInfo = row;
		-- print(row.id.. ", "..row.Pid..", "..row.name..", "..row.imagesLocation)
	end

	return pokemonInfo;

end

function getIdListOfPokemons()
	local PidList = {}
	local count = 1;
	sql = "SELECT Pid FROM pokemons"
	for row in db:nrows(sql) do
		table.insert(PidList, row.Pid)
	end
	-- print(table.getn(PidList))
	return PidList;
end

function getPokemonAttackInfo(pID)
	local pokemonInfo;


	sql = "SELECT * FROM attacks WHERE Pid == " .. pID

	for row in db:nrows(sql) do
		pokemonInfo = row;
		-- print(row.Pid.. ", "..row.attack1..", "..row.attack2..", "..row.attack3..", "..row.attack4)
		-- print(row.attack1Damage..", "..row.attack2Damage..", "..row.attack3Damage..", "..row.attack4Damage)
	end

	return pokemonInfo;

end
function getPokemonStatsInfo(pID)
	local pokemonInfo;

	sql = "SELECT * FROM stats WHERE Pid == " .. pID

	for row in db:nrows(sql) do
		pokemonInfo = row;
	end

	return pokemonInfo;

end