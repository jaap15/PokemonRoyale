-----------------------------------------------------------------------------------------
--
-- help.lua
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
local function exitButtonEvent(event)
    if ("ended" == event.phase) then
        audio.play(menuClick, {loops = 0})
        composer.gotoScene("menu")
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
    local instructionText = display.newText("You Lost!\n\nTry Again!!", display.contentCenterX, display.contentCenterY-150)

    -- Game Background


    -- Creating a button widget, this button returns us to the menu
    local exitButton = widget.newButton({    
        id = "exitButton",
        label = "Quit",    
        labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
        width = 300,
        height = 60,
        fontSize = 30,
        defaultFile = "images/menuScene/menuBtn.png",
        overFile  = "images/menuScene/menuBtnOnClick.png",
        onEvent = exitButtonEvent
    } ) 

    exitButton.x = display.contentCenterX
    exitButton.y = display.contentCenterY+(display.contentCenterY/1.9)



    -- Adding all objects to the scene group
    sceneGroup:insert(instructionText)
    sceneGroup:insert(exitButton)
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
        print("Inside loser.lua phase will of show")

        for i = 1, #enemyList do
            print("Deleting enemy".. i)
            enemyList[i]:destroyTrainer()
        end
        
        if trainer.Pokemans ~= nil then
            print("Deleting Player")
            removeObjectList(trainer.Pokemans, true);
        else
            print("Player already deleted")
        end

        print("leaving loser.lua phase will of show")
        
        composer.removeScene("fight")
        composer.removeScene("game")
        composer.removeScene("menu")

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