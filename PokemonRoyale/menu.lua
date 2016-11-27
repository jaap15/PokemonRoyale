-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------

local composer = require("composer")

-- Scene Creation / Manipulation
local scene = composer.newScene()

-- Widget Creation / Manipulation
-- Used for buttons, sliders, radio buttons
local widget = require("widget")
local Pokemon = require ("Pokemon")
local e_trainer = require("Enemy_Trainer")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local sceneGroup
enemyList = {} --holds all of the enemy objects that the player will battle

-- startButtonEvent()
--      input: none
--      output: none
--      
--      This function just switches from the menu scene to the game scene
local function startButtonEvent(event)
	if ("ended" == event.phase) then
        -- enemyList[1] = e_trainer:create(3)
        -- enemyList[2] = e_trainer:create(2)
		composer.gotoScene("game")
	end
end

-- helpButtonEvent()
--      input: none
--      output: none
--      
--      This function just switches from the menu scene to the help scene
local function helpButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("help")
    end
end

-- gameButtonEvent()
--      input: none
--      output: none
--      
--      This function just switches from the menu scene to the help scene
local function gameButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("fight")
    end
end

local function animationIntro()
    local function slashAnimation()
        local sheetName = require("images.menuScene.animations.slash")
        local spriteSheetData = sheetName:getSheet()
        --Creating the image sheet
        local slashSheet = graphics.newImageSheet( "images/menuScene/animations/slash.png", spriteSheetData)
        --Getting the sequence data from the sprite sheet file
        local sequenceData = sheetName:getSequence()

        animation = display.newSprite( slashSheet, sequenceData)
        animation.x = display.contentCenterX-200
        animation.y = 400
        animation:scale(2,2)
        animation:play()
        sceneGroup:insert( animation )

        local sheetName = require("images.menuScene.animations.slash")
        local spriteSheetData = sheetName:getSheet()
        --Creating the image sheet
        local slashSheet = graphics.newImageSheet( "images/menuScene/animations/slash.png", spriteSheetData)
        --Getting the sequence data from the sprite sheet file
        local sequenceData = sheetName:getSequence()

        animation = display.newSprite( slashSheet, sequenceData)
        animation.x = display.contentCenterX+200
        animation.y = 400
        animation.xScale = -1
        animation:scale(2,2)
        animation:play()
        sceneGroup:insert( animation )        
    end

    local function menuTitle()
        -- Game Background
        menuBG = display.newImage("images/menuScene/menuTitle.png")
        menuBG:scale(2,2)
        menuBG.x = display.contentCenterX
        menuBG.y = 400
        sceneGroup:insert( menuBG )
    end

    timer.performWithDelay(500, slashAnimation)
    timer.performWithDelay(1250, menuTitle)


end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
--      input: none
--      output: none
--
--      This function creates all the objects that will be used in the scene and adds
--      them to the scene group.
function scene:create( event )

    sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Game Title / Image 

    -- Creating the start button, sends us from the menu scene to the game scene
    local startButton = widget.newButton({    
            id = "startButton",
            label = "Start",    
            labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
            width = 300,
            height = 60,
            fontSize = 30,
            defaultFile = "images/menuScene/menuBtn.png",
            overFile  = "images/menuScene/menuBtnOnClick.png",
            onEvent = startButtonEvent 
        } )    

    -- Creating the help button, sends us from the menu scene to the help scene
    local helpButton = widget.newButton({    
            id = "helpButton",
            label = "Help",
            labelColor = { default={ 1, 1, 0 }, over={ 0, 0, 0, 0.5 } },
            width = 300,
            height = 60,
            fontSize = 30,
            defaultFile = "images/menuScene/menuBtn.png",
            overFile  = "images/menuScene/menuBtnOnClick.png",
            onEvent = helpButtonEvent 
        } )  

    animationIntro()

    -- Positioning all objects on the screen
    startButton.x = display.contentCenterX
    startButton.y = display.contentCenterY+(display.contentCenterY/1.9)
    helpButton.x = display.contentCenterX
    helpButton.y = display.contentCenterY+(display.contentCenterY/1.5)

    -- Adding all objects to the scene group, this will bind these object to the scene
    -- and they will be removed / replaced when switching to and from scenes
    sceneGroup:insert( startButton )
    sceneGroup:insert( helpButton )
end


-- show()
--      input: none
--      output: none
--
--      This function destroys the game scenes when its swapped to the menu scene
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        composer.removeScene("game")

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

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
        composer.removeScene("menu")

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