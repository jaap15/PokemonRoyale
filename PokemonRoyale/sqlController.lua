-----------------------------------------------------------------------------------------
--
-- sqlController.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
--
-- Trainer object. Keeps track of all the player's pokemon and inventory. 
-----------------------------------------------------------------------------------------

-- Corona SDK sqlite3 package
require "sqlite3"

-- Pointing to our SQL-lite file
local sql;
local path = system.pathForFile("Database.db", system.ResourceDirectory)

-- Opening Database.db
local db = sqlite3.open(path)

-- onSystemEvent()
--      input: none
--      output: none
--      
--      Closing our database file when we exit the application
local function onSystemEvent(event)
    if(event.type == "applicationExit") then
        db:close()
    end
end

-- Runtime listener for closing the database
Runtime:addEventListener("system", onSystemEvent)

-- getPokemonTableInfo()
--      input: chosePokemon
--      output: none
--      
--      This grabs the chosePokemon from the SQL-lite database
function getPokemonTableInfo(chosePokemon)
	local pokemonInfo;

	if tonumber(chosePokemon) then
		-- Number passed as parameter
		sql = "SELECT * FROM pokemons WHERE Pid == " .. chosePokemon
	else
		-- Name passed as parameter
		sql = 'SELECT * FROM pokemons WHERE name == "' .. chosePokemon .. '"'
	end

	-- Setting database information to object
	for row in db:nrows(sql) do
		pokemonInfo = row;
	end

	return pokemonInfo;
end

-- getEtrainerInfo()
--      input: trainerChoice
--      output: none
--      
--      This grabs the enemyTrainerInfo from the SQL-lite database
function getEtrainerInfo(trainerChoice)

	local trainerInfo
	
	if tonumber(trainerChoice) then
		-- Number passed as a parameter
		sql = "SELECT * FROM Enemy_Trainers WHERE ID == " ..trainerChoice
	else
		-- Name passed as parameter
		sql = 'SELECT * FROM Enemy_Trainers WHERE Trainer_Name == "' ..trainerChoice ..'"'
	end
	
	-- Setting database information to object
	for row in db:nrows(sql) do
		trainerInfo = row
	end
	
	return trainerInfo
end

-- getIdListOfPokemons()
--      input: none
--      output: none
--      
--      This grabs the PID from all pokemon in the database
function getIdListOfPokemons()
	local PidList = {}
	local count = 1;
	sql = "SELECT Pid FROM pokemons"
	for row in db:nrows(sql) do
		table.insert(PidList, row.Pid)
	end
	return PidList;
end


-- getIdListofTrainers()
--      input: none
--      output: none
--      
--      This grabs the ID from all enemy trainers in the database
function getIdListofTrainers()
	local IdList = {}
	local count = 1
	sql = "SELECT ID FROM Enemy_Trainers"
	for row in db:nrows(sql) do
		table.insert(IdList, row.ID)
	end
	return IdList
end

-- getPokemonAttackInfo()
--      input: pID
--      output: none
--      
--      This grabs 1 pid from a pokemon in database
function getPokemonAttackInfo(pID)
	local pokemonInfo;
	sql = "SELECT * FROM attacks WHERE Pid == " .. pID
	for row in db:nrows(sql) do
		pokemonInfo = row;
	end
	return pokemonInfo;
end

-- getPokemonStatsInfo()
--      input: pID
--      output: none
--      
--      This grabs 1 ID from an enemy trainer in database
function getPokemonStatsInfo(pID)
	local pokemonInfo;
	sql = "SELECT * FROM stats WHERE Pid == " .. pID
	for row in db:nrows(sql) do
		pokemonInfo = row;
	end
	return pokemonInfo;
end