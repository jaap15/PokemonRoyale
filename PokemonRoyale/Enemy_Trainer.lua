-----------------------------------------------------------------------------------------
--
-- Enemy_Trainer.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------
require("sqlController")
local pokemon = require("Pokemon")

enemy_trainer = {tag = "Enemy_Trainer", E_Pokemans = {}, E_Items = {}}

function enemy_trainer:new(o)
	
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	return o
end

function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

function enemy_trainer:create(trainerChoice)
	
	print("debug 1")
	
	local trainerInfo = getEtrainerInfo(trainerChoice)
	
	print_r(trainerInfo)
	--print("debug 2")
	--print(trainerInfo.ID.. ", "..trainerInfo.Trainer_Name..", "..trainerInfo.Pokemon1..", "..trainerInfo.Pokemon2..", "..trainerInfo.Pokemon3..", "..trainerInfo.Pokemon4", "..trainerInfo.Pokemon5", "..trainerInfo.Pokemon6)
	--print(row.attack1Damage..", "..row.attack2Damage..", "..row.attack3Damage..", "..row.attack4Damage)
	
	local location = trainerInfo.imagesLocation
	--self.trainer = display.newImage(location)
	--self.trainer.isVisible = false
	--self.trainer.pp = self
	--self.trainer.tag = trainerInfo.Trainer_Name
	
	--print(trainerInfo.Pokemon1)
	--self:populatePokemon(trainerInfo)
	
	self.E_Pokemans[1] = pokemon:new()
	self.E_Pokemans[1]:create(trainerInfo.Pokemon1)
	
	self.E_Pokemans[2] = pokemon:new()
	self.E_Pokemans[2]:create(trainerInfo.Pokemon2)
	
	self.E_Pokemans[3] = pokemon:new()
	self.E_Pokemans[3]:create(trainerInfo.Pokemon3)
	
	self.E_Pokemans[4] = pokemon:new()
	self.E_Pokemans[4]:create(trainerInfo.Pokemon4)
	
	self.E_Pokemans[5] = pokemon:new()
	self.E_Pokemans[5]:create(trainerInfo.Pokemon5)
	
	self.E_Pokemans[6] = pokemon:new()
	self.E_Pokemans[6]:create(trainerInfo.Pokemon6)
end

function enemy_trainer:populatePokemon(trainerInfo)
	
	
	
end

return enemy_trainer