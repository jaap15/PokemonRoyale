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

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- startButtonEvent()
--      input: none
--      output: none
--      
--      This function just switches from the menu scene to the game scene
local function startButtonEvent(event)
	if ("ended" == event.phase) then
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

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Game Title / Image 

    -- Game Background
    menuBG = display.newImage("images/menuTitle2.png")
    menuBG:scale(2,2)
    menuBG.x = display.contentCenterX
    menuBG.y = 400

    -- Creating the start button, sends us from the menu scene to the game scene
    local startButton = widget.newButton({    
            id = "startButton",
            label = "Start",    
            labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
            width = 300,
            height = 60,
            fontSize = 30,
            defaultFile = "images/button2.png",
            overFile  = "images/button2over.png",
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
            defaultFile = "images/button2.png",
            overFile  = "images/button2over.png",
            onEvent = helpButtonEvent 
        } )  

    -- Creating the help button, sends us from the menu scene to the help scene
    local gameButton = widget.newButton({    
            id = "gameButton",
            label = "Game",  
            labelColor = { default={ 1, 1, 0 }, over={ 0, 0, 0, 0.5 } },
            width = 300,
            height = 60,
            fontSize = 30,
            defaultFile = "images/button2.png",
            overFile  = "images/button2over.png",
            onEvent = gameButtonEvent 
        } )      

    -- Positioning all objects on the screen
    startButton.x = display.contentCenterX
    startButton.y = display.contentCenterY+(display.contentCenterY/1.9)
    helpButton.x = display.contentCenterX
    helpButton.y = display.contentCenterY+(display.contentCenterY/1.5)
    gameButton.x = display.contentCenterX
    gameButton.y = display.contentCenterY+(display.contentCenterY/1.2)    

    -- Adding all objects to the scene group, this will bind these object to the scene
    -- and they will be removed / replaced when switching to and from scenes
    sceneGroup:insert( menuBG )
    sceneGroup:insert( startButton )
    sceneGroup:insert( helpButton )
    sceneGroup:insert( gameButton )
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