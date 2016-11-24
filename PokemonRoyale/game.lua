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
require("sqlController");

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- ----------------------------------------------------------------------------------
local totalPokemons = 9
local pokemon = Pokemon:new( {HP=150} );
teamIndex = 1
thumbX = 173;
thumbY = 900;
yourTeam = {}
local thumbList = {}
local select1;
local select2;
local select3;
local pokeInfo1;
local pokeInfo2;
local pokeInfo3;


local function removeThumbs()
    for i = 1, #thumbList do
        if(thumbList[i] ~= nil) then
            thumbList[i]:removeSelf();
            thumbList[i] = nil;
        end
    end
end

local function selectionListener(event)
    if (event.target == select1) then
        thumbList[teamIndex] = display.newImage(pokeInfo1.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        yourTeam[teamIndex] = pokemon:new({xPos=125, yPos=280});
        yourTeam[teamIndex]:create(pokeInfo1.Pid)
    elseif (event.target == select2) then
        thumbList[teamIndex] = display.newImage(pokeInfo2.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        yourTeam[teamIndex] = pokemon:new({xPos=360, yPos=280});
        yourTeam[teamIndex]:create(pokeInfo2.Pid)
    elseif (event.target == select3) then
        thumbList[teamIndex] = display.newImage(pokeInfo3.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        yourTeam[teamIndex] = pokemon:new({xPos=590, yPos=280});
        yourTeam[teamIndex]:create(pokeInfo3.Pid)
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
        removeThumbs();
        composer.gotoScene("fight")
    end
end

function teamSelect()
    selectText = display.newText("Select a Pokemon", display.contentCenterX, 100, native.systemFont, 78, "center");
    teamText = display.newText("Your Team", display.contentCenterX, 800, native.systemFont, 78, "center");
    local random1 = math.random(1, totalPokemons);
    local random2 = math.random(1, totalPokemons);
    local random3 = math.random(1, totalPokemons);

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
