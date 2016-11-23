-----------------------------------------------------------------------------------------
--
-- help2.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- returnButtonEvent()
--      input: none
--      output: none
--      
--      This function just switches from the help scene to the menu scene
local function returnButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("menu")
    end
end

local function backButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("help")
    end
end

local function nextButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("help3")
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

    -- Displaying game instructions
    local instructionText1 = display.newText("First, you must assemble your team of\nPokemon. You will pick one at a time from\na random selection of 3, until you have a\nfull team of 6.", display.contentCenterX, display.contentCenterY-150)

    -- Game Background

    -- Display X image over the voltorb

    -- Creating a button widget, this button returns us to the menu
    local returnButton = widget.newButton({    
        id = "returnButton",
        label = "Return",    
        width = 300,
        height = 60,
        fontSize = 30,
        defaultFile = "images/button.png",
        onEvent = returnButtonEvent 
    } )

    local backButton = widget.newButton({    
        id = "backButton",
        label = "Back",    
        width = 300,
        height = 60,
        fontSize = 30,
        defaultFile = "images/button.png",
        onEvent = backButtonEvent 
    } )

    local nextButton = widget.newButton({    
        id = "nextButton",
        label = "Next",    
        width = 300,
        height = 60,
        fontSize = 30,
        defaultFile = "images/button.png",
        onEvent = nextButtonEvent 
    } )

    -- Positioning all objects on the scene
    returnButton.x = display.contentCenterX
    returnButton.y = display.contentCenterY+(display.contentCenterY/1.5)

    backButton.x = display.contentCenterX
    backButton.y = display.contentCenterY+300

    nextButton.x = display.contentCenterX
    nextButton.y = display.contentCenterY+200

    -- Adding all objects to the scene group
    sceneGroup:insert(instructionText1)
    sceneGroup:insert(returnButton)
    sceneGroup:insert(backButton)
    sceneGroup:insert(nextButton)
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