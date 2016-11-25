-----------------------------------------------------------------------------------------
--
-- game.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local Pokemon = require ("Pokemon");
local trainer = require("Trainer")
require("sqlController");

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- ----------------------------------------------------------------------------------
local pokemonsAvailable = getIdListOfPokemons()
local pokemon = Pokemon:new( {HP=150} );
teamIndex = 1
thumbX = 173;
thumbY = 900;
local thumbList = {}
local select1;
local select2;
local select3;
local pokeInfo1;
local pokeInfo2;
local pokeInfo3;


function removeObjectList(objectList, pokemonObjects)
    for i = 1, #objectList do
        if(pokemonObjects) then
            if(objectList[i] ~= nil) then
		        objectList[i].pokemon.healthBar:removeSelf();
                objectList[i].pokemon.damageBar:removeSelf();
                objectList[i].pokemon.selectViewTN:removeSelf();
                objectList[i].pokemon.battleView:removeSelf();
                objectList[i].pokemon.selectView:removeSelf();
                objectList[i].pokemon:removeSelf();
                objectList[i] = nil;
            end
        else
            if(objectList[i] ~= nil) then
                objectList[i]:removeSelf();
                objectList[i] = nil;
            end
        end
    end
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

local function selectionListener(event)
    if (event.target == select1) then
        thumbList[teamIndex] = display.newImage(pokeInfo1.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=125, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo1.Pid)
    elseif (event.target == select2) then
        thumbList[teamIndex] = display.newImage(pokeInfo2.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=360, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo2.Pid)
    elseif (event.target == select3) then
        thumbList[teamIndex] = display.newImage(pokeInfo3.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=590, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo3.Pid)
    end
    if (thumbX < 519) then
        thumbX = thumbX + 173;
    else
        thumbX = 173;
        thumbY = 1050;
    end
    teamIndex = teamIndex + 1;
    if (teamIndex < 7) then
        selectText:removeSelf();
        teamText:removeSelf();
        select1:removeEventListener("tap", selectionListener);
        select2:removeEventListener("tap", selectionListener);
        select3:removeEventListener("tap", selectionListener);
        select1:removeSelf();
        select2:removeSelf();
        select3:removeSelf();
        teamSelect();
    elseif (teamIndex == 7) then
        selectText:removeSelf();
        teamText:removeSelf();
        select1:removeEventListener("tap", selectionListener);
        select2:removeEventListener("tap", selectionListener);
        select3:removeEventListener("tap", selectionListener);
        select1:removeSelf();
        select2:removeSelf();
        select3:removeSelf();
        removeObjectList(thumbList, false);
		composer.setVariable("trainer", trainer)
        composer.gotoScene("fight")
    end
    
    local pokemon1 = trainer.Pokemans[1].pokemon.selectView
    pokemon1.x = display.contentCenterX
    pokemon1.y = display.contentCenterX
    pokemon1.width = 500
    pokemon1.height = 500
end

function teamSelect()
    selectText = display.newText("Select a Pokemon", display.contentCenterX, 100, native.systemFont, 78, "center");
    teamText = display.newText("Your Team", display.contentCenterX, 800, native.systemFont, 78, "center");
    
    local random1 = math.random(1, #pokemonsAvailable);
    local random2 = math.random(1, #pokemonsAvailable);
    local random3 = math.random(1, #pokemonsAvailable);

    pokeInfo1 = getPokemonTableInfo(random1)
    pokeInfo2 = getPokemonTableInfo(random2)
    pokeInfo3 = getPokemonTableInfo(random3)

    select1 = display.newImage(pokeInfo1.imagesLocation.."/select.png", 125, 280);
    select2 = display.newImage(pokeInfo2.imagesLocation.."/select.png", 360, 280);
    select3 = display.newImage(pokeInfo3.imagesLocation.."/select.png", 590, 280);
    select1:scale(2,2)
    select2:scale(2,2)
    select3:scale(2,2)
    select1:addEventListener("tap", selectionListener);
    select2:addEventListener("tap", selectionListener);
    select3:addEventListener("tap", selectionListener);
end

-- Dummy table to test selection
pokemonTable = {
    {image="images/p1.png", thumb="images/t1.png"},
    {image="images/p2.png", thumb="images/t2.png"},
    {image="images/p3.png", thumb="images/t3.png"},
    {image="images/p4.png", thumb="images/t4.png"},
    {image="images/p5.png", thumb="images/t5.png"},
    {image="images/p6.png", thumb="images/t6.png"},
    {image="images/p7.png", thumb="images/t7.png"},
    {image="images/p8.png", thumb="images/t8.png"},
    {image="images/p9.png", thumb="images/t9.png"}
};
teamIndex = 1
thumbX = 70;
thumbY = 300;
yourTeam = {}

local function selectionListener(event)
    if (event.target == select1) then
        thumb = display.newImage(pokemonTable[random1].thumb, thumbX, thumbY);
        yourTeam[teamIndex] = {image=pokemonTable[random1].image, thumb=pokemonTable[random1].thumb};
    elseif (event.target == select2) then
        thumb = display.newImage(pokemonTable[random2].thumb, thumbX, thumbY);
        yourTeam[teamIndex] = {image=pokemonTable[random2].image, thumb=pokemonTable[random2].thumb};
    elseif (event.target == select3) then
        thumb = display.newImage(pokemonTable[random3].thumb, thumbX, thumbY);
        yourTeam[teamIndex] = {image=pokemonTable[random3].image, thumb=pokemonTable[random3].thumb};
    end
    if (thumbX < 250) then
        thumbX = thumbX + 90;
    else
        thumbX = 70;
        thumbY = 400;
    end
    teamIndex = teamIndex + 1;
    if (teamIndex < 7) then
        selectText:removeSelf();
        teamText:removeSelf();
        select1:removeEventListener("tap", selectionListener);
        select2:removeEventListener("tap", selectionListener);
        select3:removeEventListener("tap", selectionListener);
        select1:removeSelf();
        select2:removeSelf();
        select3:removeSelf();
        teamSelect();
    elseif (teamIndex == 7) then
        selectText:removeSelf();
        select1:removeEventListener("tap", selectionListener);
        select2:removeEventListener("tap", selectionListener);
        select3:removeEventListener("tap", selectionListener);
        select1:removeSelf();
        select2:removeSelf();
        select3:removeSelf();
    end
end

function teamSelect()
    selectText = display.newText("Select a Pokemon", display.contentCenterX, 30, native.systemFont, 18, "center");
    teamText = display.newText("Your Team", display.contentCenterX, 200, native.systemFont, 18, "center");
    random1 = math.random(1, #pokemonTable);
    random2 = math.random(1, #pokemonTable);
    random3 = math.random(1, #pokemonTable);
    select1 = display.newImage(pokemonTable[random1].image, 70, 90);
    select2 = display.newImage(pokemonTable[random2].image, 160, 90);
    select3 = display.newImage(pokemonTable[random3].image, 250, 90);
    select1:addEventListener("tap", selectionListener);
    select2:addEventListener("tap", selectionListener);
    select3:addEventListener("tap", selectionListener);
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
--      input: none
--      output: none
--
--      This function creates all the objects that will be used in the scene and adds
--      them to the scene group. It also loads all the sound files that we will be using.
function scene:create( event )

    sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Game Background

    -- Positioning menuBG object on the screen

    -- Positioning all objects on the scene

    -- Adding all objects to the scene group

end

-- show()
--      input: none
--      output: none
--
--      This function does nothing for us, but is still part of Corona SDK scene creation requirements
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        teamSelect();
    end
end


-- hide()
--      input: none
--      output: none
--
--      This function does nothing for us, but is still part of Corona SDK scene creation requirements
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        composer.removeScene("game")
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end


-- destroy()
--      input: none
--      output: none
--
--      This function does nothing for us, but is still part of Corona SDK scene creation requirements
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
