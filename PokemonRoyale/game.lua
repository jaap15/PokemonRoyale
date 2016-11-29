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
trainer = require("Trainer")
require("sqlController");

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- ----------------------------------------------------------------------------------
local pokemonsAvailable = getIdListOfPokemons()
local trainersAvailable = getIdListofTrainers()
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
local random1;
local random2;
local random3;

-- composer.setVariable("trainersAvailable", trainersAvailable)

-- Local Sounds
local menuClick = audio.loadStream("sounds/pokemonSelectSound.mp3")
local menuTransition = audio.loadStream("sounds/pokeballEffect2.mp3")

function openingAnimations()
    local sheetName = require("images.fightScene.animations.battleIntro")
    local spriteSheetData = sheetName:getSheet()
    --Creating the image sheet
    local battleSheet = graphics.newImageSheet( "images/fightScene/animations/battleIntro.png", spriteSheetData)
    --Getting the sequence data from the sprite sheet file
    local sequenceData = sheetName:getSequence()

    animation = display.newSprite( battleSheet, sequenceData)
    animation.x = display.contentCenterX
    animation.y = display.contentCenterY
    animation:scale(2,2)
    animation:play()
    sceneGroup:insert( animation )

    local sheetName = require("images.fightScene.animations.battleIntro2")
    local spriteSheetData = sheetName:getSheet()
    --Creating the image sheet
    local battleSheet = graphics.newImageSheet( "images/fightScene/animations/battleIntro2.png", spriteSheetData)
    --Getting the sequence data from the sprite sheet file
    local sequenceData = sheetName:getSequence()

    local function animateSecond()
        animation = display.newSprite( battleSheet, sequenceData)
        animation.x = display.contentCenterX+100
        animation.y = display.contentCenterY
        animation:scale(4,4)
        animation:play()
        local function removeAnimationSecond()
            print("TEST")
            animation:pause()
            animation.x = 5000
            animation.isVisible = false
        end
        timer.performWithDelay(1900, removeAnimationSecond)
    end
    timer.performWithDelay(2000, animateSecond)
    sceneGroup:insert( animation )    
end

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

local function selectionListener(event)
    if (event.target == select1) then
        thumbList[teamIndex] = display.newImage(pokeInfo1.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=125, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo1.Pid)
        audio.play(menuClick, {loops = 0})
        table.remove(pokemonsAvailable, random1)
    elseif (event.target == select2) then
        thumbList[teamIndex] = display.newImage(pokeInfo2.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=360, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo2.Pid)
        audio.play(menuClick, {loops = 0})
        table.remove(pokemonsAvailable, random2)
    elseif (event.target == select3) then
        thumbList[teamIndex] = display.newImage(pokeInfo3.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=590, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo3.Pid)
        audio.play(menuClick, {loops = 0})
        table.remove(pokemonsAvailable, random3)
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
        openingAnimations()
        audio.play(menuTransition, {loops = 0})
        selectText:removeSelf();
        teamText:removeSelf();
        select1:removeEventListener("tap", selectionListener);
        select2:removeEventListener("tap", selectionListener);
        select3:removeEventListener("tap", selectionListener);
        select1:removeSelf();
        select2:removeSelf();
        select3:removeSelf();
        removeObjectList(thumbList, false);
        print("debug")
        trainer:create()
        for i = 1, #trainer.Pokemans do
            trainer.Pokemans[i]:drawHealthBar("player")
        end
        print("debug2")   
            -- composer.setVariable("trainer", trainer)
        local function moveToNextScene()
            composer.gotoScene("fight")
        end
        timer.performWithDelay(4500, moveToNextScene)
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
    
    random1 = math.random(#pokemonsAvailable);
    random2 = math.random(#pokemonsAvailable);

    while random2 == random1 do
        random2 = math.random(#pokemonsAvailable);
    end

    random3 = math.random(#pokemonsAvailable);

    while random3 == random1 or random3 == random2 do
        random3 = math.random(#pokemonsAvailable);
    end

    pokeInfo1 = getPokemonTableInfo(pokemonsAvailable[random1])
    pokeInfo2 = getPokemonTableInfo(pokemonsAvailable[random2])
    pokeInfo3 = getPokemonTableInfo(pokemonsAvailable[random3])


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

    -- trainer = Trainer:new()
    -- trainer:create()
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