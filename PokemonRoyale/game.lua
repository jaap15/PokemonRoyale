-----------------------------------------------------------------------------------------
--
-- game.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- ----------------------------------------------------------------------------------

-- Dummy table to test selection
pokemonTable = {
    {image="images/gameScene/p1.png", thumb="images/gameScene/t1.png"},
    {image="images/gameScene/p2.png", thumb="images/gameScene/t2.png"},
    {image="images/gameScene/p3.png", thumb="images/gameScene/t3.png"},
    {image="images/gameScene/p4.png", thumb="images/gameScene/t4.png"},
    {image="images/gameScene/p5.png", thumb="images/gameScene/t5.png"},
    {image="images/gameScene/p6.png", thumb="images/gameScene/t6.png"},
    {image="images/gameScene/p7.png", thumb="images/gameScene/t7.png"},
    {image="images/gameScene/p8.png", thumb="images/gameScene/t8.png"},
    {image="images/gameScene/p9.png", thumb="images/gameScene/t9.png"}
};
teamIndex = 1
thumbX = 173;
thumbY = 900;
yourTeam = {}

local function selectionListener(event)
    if (event.target == select1) then
        thumb = display.newImage(pokemonTable[random1].thumb, thumbX, thumbY);
        thumb:scale(3,3)
        yourTeam[teamIndex] = {image=pokemonTable[random1].image, thumb=pokemonTable[random1].thumb};
    elseif (event.target == select2) then
        thumb = display.newImage(pokemonTable[random2].thumb, thumbX, thumbY);
        thumb:scale(3,3)
        yourTeam[teamIndex] = {image=pokemonTable[random2].image, thumb=pokemonTable[random2].thumb};
    elseif (event.target == select3) then
        thumb = display.newImage(pokemonTable[random3].thumb, thumbX, thumbY);
        thumb:scale(3,3)
        yourTeam[teamIndex] = {image=pokemonTable[random3].image, thumb=pokemonTable[random3].thumb};
    end
    if (thumbX < 519) then
        thumbX = thumbX + 173;
    else
        thumbX = 173;
        thumbY = 1000;
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
        composer.gotoScene("fight")
    end
end

function teamSelect()
    selectText = display.newText("Select a Pokemon", display.contentCenterX, 100, native.systemFont, 78, "center");
    teamText = display.newText("Your Team", display.contentCenterX, 800, native.systemFont, 78, "center");
    random1 = math.random(1, #pokemonTable);
    random2 = math.random(1, #pokemonTable);
    random3 = math.random(1, #pokemonTable);
    select1 = display.newImage(pokemonTable[random1].image, 173, 280);
    select2 = display.newImage(pokemonTable[random2].image, 346, 280);
    select3 = display.newImage(pokemonTable[random3].image, 519, 280);
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