-----------------------------------------------------------------------------------------
--
-- game.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
--
-- This is the beginning of the game, where the user selects his team of pokemon. From
-- all the pokemon in the database, we will select 3 at random and display them so the user
-- may make his choice. This happens six times before the player's team is locked in and
-- an animation plays that takes us into the fight scene.
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-- Pokemon Class, creates a Pokemon object
local Pokemon = require ("Pokemon");

-- Trainer Class, creates an Enemy Trainer object
trainer = require("Trainer")

-- SQLController class. All our pokemon values and trainer pokemon are saved into SQL-Lite
-- files so we created an SQLController to grab all the information.
require("sqlController");

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- ----------------------------------------------------------------------------------

-- List of all pokemon in database
local pokemonsAvailable = getIdListOfPokemons()

-- List of all trainers in database
local trainersAvailable = getIdListofTrainers()

-- Creating a defauly pokemon object
local pokemon = Pokemon:new( {HP=150} );

-- Tracks which pokemon this is, starts at 1 ends at 6
local teamIndex = 1

-- Setting location of thumbnail images to be displayed
local thumbX = 173;
local thumbY = 900;
local thumbList = {} -- Table to keep thumbnails in

-- These 3 variables represent the 3 random pokemon we will select from database
local select1;
local select2;
local select3;

-- These 3 variables hold the 3 random pokemon images
local pokeInfo1;
local pokeInfo2;
local pokeInfo3;

-- These variables are the random numbers that help us grab the 3 pokemon from database
local random1;
local random2;
local random3;

-- Local Sounds
local menuClick = audio.loadStream("sounds/pokemonSelectSound.mp3")
local menuTransition = audio.loadStream("sounds/pokeballEffect2.mp3")

-- openingAnimations()
--      input: none
--      output: none
--      
--      This is the animation that occurs after the players team is made. It has two local functions
--      embedded in it, this is animations and action can be executed sequentially rather than 
--      at the same time.
function openingAnimations()

    -- This the first animation that plays
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

    -- animateSecond()
    --      input: none
    --      output: none
    --      
    --      This is the second animation that plays, it is in a function so that it will be played
    --      after the first one has finished
    local function animateSecond()
        animation = display.newSprite( battleSheet, sequenceData)
        animation.x = display.contentCenterX+100
        animation.y = display.contentCenterY
        animation:scale(4,4)
        animation:play()

        -- removeAnimationSecond()
        --      input: none
        --      output: none
        --      
        --      Removes the second animation after a certain period of time.       
        local function removeAnimationSecond()
            animation:pause()
            animation.x = 5000
            animation.isVisible = false
        end
        -- Removed second animation
        timer.performWithDelay(1900, removeAnimationSecond)
    end
    -- Playing second animation
    timer.performWithDelay(2000, animateSecond)

    -- Adding to sceneGroup
    sceneGroup:insert( animation )    
end

-- removeObjectList()
--      input: none
--      output: none
--      
--      This is called when we are about the leave the scene, it cleans up all the pokemon objects
--      that didn't get picked by the player.
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

-- selectionListener()
--      input: none
--      output: none
--      
--      This is event listener is attached to each pokemon thumbnail and adds the Pokemon to the trainers
--      team, then removes the other 2 from the list.
local function selectionListener(event)
    -- Playing pokemon select sound
    audio.play(menuClick, {loops = 0})

    -- Seeing which pokemon was selected
    if (event.target == select1) then
        -- Creating a thumbnail of the pokemon selected and placing it at bottom of screen
        thumbList[teamIndex] = display.newImage(pokeInfo1.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=125, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo1.Pid)
        table.remove(pokemonsAvailable, random1)
    elseif (event.target == select2) then
        -- Creating a thumbnail of the pokemon selected and placing it at bottom of screen
        thumbList[teamIndex] = display.newImage(pokeInfo2.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=360, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo2.Pid)
        table.remove(pokemonsAvailable, random2)
    elseif (event.target == select3) then
        -- Creating a thumbnail of the pokemon selected and placing it at bottom of screen
        thumbList[teamIndex] = display.newImage(pokeInfo3.imagesLocation.."/select.png", thumbX, thumbY);
        thumbList[teamIndex]:scale(1.5,1.5)
        trainer.Pokemans[teamIndex] = pokemon:new({xPos=590, yPos=280});
        trainer.Pokemans[teamIndex]:create(pokeInfo3.Pid)
        table.remove(pokemonsAvailable, random3)
    end

    -- This sets the X and Y of where the thumbnails are to be placed.
    if (thumbX < 519) then
        thumbX = thumbX + 173;
    else
        thumbX = 173;
        thumbY = 1050;
    end
    -- Incrementing player's pokemon index
    teamIndex = teamIndex + 1;

    -- If all 6 pokemon has been selected, its time to remove everything and go to the next scene.
    -- If not, its time to remove everything and move on to draw the next 3 pokemon.
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
        select1:removeEventListener("tap", selectionListener);
        select2:removeEventListener("tap", selectionListener);
        select3:removeEventListener("tap", selectionListener);

        -- removeItems()
        --      input: none
        --      output: none
        --      
        --      This function does the same thing as above, but since we are played a transition animation
        --      going into the fight scene, we want to wait until the animation is over to visually remove scene.
        local function removeItems()
            selectText:removeSelf();
            teamText:removeSelf();
            select1:removeSelf();
            select2:removeSelf();
            select3:removeSelf();
            removeObjectList(thumbList, false);
            composer.setVariable("trainer", trainer)
        end

        -- Removing pokemon thumbnails, and text
        timer.performWithDelay(4000, removeItems)
        
        -- Creating the trainer object with his 6 selected pokemon.
        trainer:create()

        -- Setting values for each 6 pokmeon
        for i = 1, #trainer.Pokemans do
            trainer.Pokemans[i]:drawHealthBar("player")
        end

        -- moveToNextScene()
        --      input: none
        --      output: none
        --      
        --      Taking us to fight scene after animation is played.
        local function moveToNextScene()
            composer.gotoScene("fight")
        end

        -- Taking us to fight scene
        timer.performWithDelay(4500, moveToNextScene)
    end
    
    -- Creating the pokemon that we just selected
    local pokemon1 = trainer.Pokemans[1].pokemon.selectView
    pokemon1.x = display.contentCenterX
    pokemon1.y = display.contentCenterX
    pokemon1.width = 500
    pokemon1.height = 500
end

-- teamSelect()
--      input: none
--      output: none
--      
--      This function draws the text of the game scene, generates the 3 random numbers that 
--      select the pokemon, grabs the correct pokemon from the table, draws them to the screen
--      and slaps event listeners on them
function teamSelect()

    -- Drawing game scene text
    selectText = display.newText("Select a Pokemon", display.contentCenterX, 100, native.systemFont, 78, "center");
    teamText = display.newText("Your Team", display.contentCenterX, 800, native.systemFont, 78, "center");
    
    -- Making random numbers for pokemon selection
    random1 = math.random(#pokemonsAvailable);
    random2 = math.random(#pokemonsAvailable);

    -- Making sure there are no repeats of pokemon
    while random2 == random1 do
        random2 = math.random(#pokemonsAvailable);
    end

    -- Thrid pokemon
    random3 = math.random(#pokemonsAvailable);

    -- No repeats
    while random3 == random1 or random3 == random2 do
        random3 = math.random(#pokemonsAvailable);
    end

    -- Creating the pokemon object from the random numbers
    pokeInfo1 = getPokemonTableInfo(pokemonsAvailable[random1])
    pokeInfo2 = getPokemonTableInfo(pokemonsAvailable[random2])
    pokeInfo3 = getPokemonTableInfo(pokemonsAvailable[random3])

    -- Drawing the images for the pokemon
    select1 = display.newImage(pokeInfo1.imagesLocation.."/select.png", 125, 280);
    select2 = display.newImage(pokeInfo2.imagesLocation.."/select.png", 360, 280);
    select3 = display.newImage(pokeInfo3.imagesLocation.."/select.png", 590, 280);

    -- Scaling the images
    select1:scale(2,2)
    select2:scale(2,2)
    select3:scale(2,2)

    -- Adding tap listeners to each pokemon
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