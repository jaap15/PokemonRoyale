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

local menu
local platformBG
local cancelBtn
local fightMenuBtn = {}
local mainMenuBtn = {}

-- Local Sounds
local menuClick = audio.loadStream("sounds/menuButtonClick.mp3")

function attack1()
    print("attack 1")
end

function attack2()
    print("attack 2")
end

function attack3()
    print("attack 3")
end

function attack4()
    print("attack 4")
end

function drawBackground()
    platformBG = display.newImage("images/GrassBG.png")
    platformBG.width = display.pixelWidth
    platformBG.height = display.pixelHeight/2
    platformBG.x = display.pixelWidth - (display.pixelWidth/2)
    platformBG.y = display.pixelHeight - (display.pixelHeight/1.33) 
end

function openPokemonMenu()
    audio.play(menuClick, {loops = 0})
    partyScreen = display.newImage("images/PartyScreen2.png")
    partyScreen.width = display.pixelWidth
    partyScreen.height = display.pixelHeight/2 
    partyScreen.x = display.pixelWidth - (display.pixelWidth/2)
    partyScreen.y = display.pixelHeight - (display.pixelHeight/4)    

    cancelBtn = display.newImage("images/cancelBtn.png")
    cancelBtn.width = 150
    cancelBtn.height = 75
    cancelBtn.x = 638
    cancelBtn.y = 1226    

    cancelBtn:addEventListener("tap", returnToMainMenu)

    menu.isVisible = false
    for cnt = 0, 3 do
        mainMenuBtn[cnt].isVisible = false
    end
end

function returnToMainMenu()
    audio.play(menuClick, {loops = 0})
    if (fightMenuBG) then
        fightMenuBG.isVisible = false
        for cnt = 0, 3 do
            fightMenuBtn[cnt].isVisible = false
        end
        cancelBtn.isVisible = false
    end

    if (partyScreen) then
        partyScreen.isVisible = false
        cancelBtn.isVisible = false
    end

    if (itemsMenu) then
        itemsMenu.isVisible = false
        cancelBtn.isVisible = false
    end

    menu.isVisible = true
    for cnt = 0, 3 do
        mainMenuBtn[cnt].isVisible = true
    end
end

function openItemsMenu ()
    itemsMenu = display.newImage("images/itemsMenu2.png")
    itemsMenu.width = display.pixelWidth
    itemsMenu.height = display.pixelHeight/2
    itemsMenu.x = display.pixelWidth - (display.pixelWidth/2)
    itemsMenu.y = display.pixelHeight - (display.pixelHeight/4)    

    cancelBtn = display.newImage("images/cancelBtn.png")
    cancelBtn.width = 150
    cancelBtn.height = 75
    cancelBtn.x = 638
    cancelBtn.y = 1226    

    cancelBtn:addEventListener("tap", returnToMainMenu)
    menu.isVisible = false
    for cnt = 0, 3 do
        mainMenuBtn[cnt].isVisible = false
    end    
end

function openMainMenu ()
    menu = display.newImage("images/MenuFull.png")
    menu.width = display.pixelWidth
    menu.height = display.pixelHeight/2

    mainMenuBtn[0] = display.newImage("images/FightButton.png")
    mainMenuBtn[0].width = 220
    mainMenuBtn[0].height = 270
    mainMenuBtn[0].x = 240
    mainMenuBtn[0].y = 828

    mainMenuBtn[1] = display.newImage("images/BagButton.png")
    mainMenuBtn[1].width = 220
    mainMenuBtn[1].height = 270   
    mainMenuBtn[1].x = 475
    mainMenuBtn[1].y = 828    
    
    mainMenuBtn[2] = display.newImage("images/PokemonButton.png")
    mainMenuBtn[2].width = 220
    mainMenuBtn[2].height = 270 
    mainMenuBtn[2].x = 240
    mainMenuBtn[2].y = 1105    

    mainMenuBtn[3] = display.newImage("images/RunButton.png")
    mainMenuBtn[3].width = 220
    mainMenuBtn[3].height = 270 
    mainMenuBtn[3].x = 475
    mainMenuBtn[3].y = 1105  

    menu.x = display.pixelWidth - (display.pixelWidth/2)
    menu.y = display.pixelHeight - (display.pixelHeight/4)    
end

function openFightMenu ()
    audio.play(menuClick, {loops = 0})
    fightMenuBG = display.newImage("images/fightMenu2.png")
    fightMenuBG.width = display.pixelWidth
    fightMenuBG.height = display.pixelHeight/2
    fightMenuBG.x = display.pixelWidth - (display.pixelWidth/2)
    fightMenuBG.y = display.pixelHeight - (display.pixelHeight/4) 

    fightMenuBtn[0] = display.newImage("images/fightMenu.png")
    fightMenuBtn[0].width = 333
    fightMenuBtn[0].height = 206 
    fightMenuBtn[0].x = 184
    fightMenuBtn[0].y = 842
    
    fightMenuBtn[1] = display.newImage("images/fightMenu.png")
    fightMenuBtn[1].width = 333
    fightMenuBtn[1].height = 206   
    fightMenuBtn[1].x = 536
    fightMenuBtn[1].y = 842
    
    fightMenuBtn[2] = display.newImage("images/fightMenu.png")
    fightMenuBtn[2].width = 333
    fightMenuBtn[2].height = 206 
    fightMenuBtn[2].x = 184
    fightMenuBtn[2].y = 1074    

    fightMenuBtn[3] = display.newImage("images/fightMenu.png")
    fightMenuBtn[3].width = 333
    fightMenuBtn[3].height = 206 
    fightMenuBtn[3].x = 536
    fightMenuBtn[3].y = 1074        

    cancelBtn = display.newImage("images/cancelBtn.png")
    cancelBtn.width = 150
    cancelBtn.height = 75
    cancelBtn.x = 638
    cancelBtn.y = 1226    

    cancelBtn:addEventListener("tap", returnToMainMenu)

    fightMenuBtn[0]:addEventListener("tap", attack1);
    fightMenuBtn[1]:addEventListener("tap", attack2);
    fightMenuBtn[2]:addEventListener("tap", attack3);
    fightMenuBtn[3]:addEventListener("tap", attack4);

    menu.isVisible = false
    for cnt = 0, 3 do
        mainMenuBtn[cnt].isVisible = false
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
--      them to the scene group. It also loads all the sound files that we will be using.
function scene:create( event )
    sceneGroup = self.view

    openMainMenu()
    drawBackground()

    mainMenuBtn[0]:addEventListener("tap", openFightMenu)
    mainMenuBtn[1]:addEventListener("tap", openPokemonMenu)
    mainMenuBtn[2]:addEventListener("tap", openItemsMenu)
    --mainMenuBtn[3]:addEventListener("tap", openFightMenu)
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
