-----------------------------------------------------------------------------------------
--
-- game.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local Pokemon = require ("Pokemon")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- ----------------------------------------------------------------------------------

local menu
local platformBG
local cancelBtn
local mainMenuBtn = {}
local fightMenuBtn = {}
local pkmnMenuBtn = {}
local pokemon = Pokemon:new( {HP=150} )
local sceneGroup

-- Local Sounds
local menuClick = audio.loadStream("sounds/menuButtonClick.mp3")

-- Fight Menu Functions
function attack1(event)
    if ( "ended" == event.phase ) then
        print("attack 1")
    end
end

function attack2(event)
    if ( "ended" == event.phase ) then
        print("attack 2")
    end
end

function attack3(event)
    if ( "ended" == event.phase ) then
        print("attack 3")
    end
end

function attack4(event)
    if ( "ended" == event.phase ) then
        print("attack 4")
    end
end

-- Pokemon Menu Functions
function select1(event)
    if ( "ended" == event.phase ) then
        print("select pokemon 1")
    end
end

function select2(event)
    if ( "ended" == event.phase ) then
        print("select pokemon 2")
    end
end

function select3(event)
    if ( "ended" == event.phase ) then
        print("select pokemon 3")
    end
end

function select4(event)
    if ( "ended" == event.phase ) then
        print("select pokemon 4")
    end
end

function select5(event)
    if ( "ended" == event.phase ) then
        print("select pokemon 5")
    end
end

function select6(event)
    if ( "ended" == event.phase ) then
        print("select pokemon 6")
    end
end

-- Item Menu Functions
function item1(event)
    if ( "ended" == event.phase ) then
        print("item 1")
    end
end

function item2(event)
    if ( "ended" == event.phase ) then
        print("item 2")
    end
end

function item3(event)
    if ( "ended" == event.phase ) then
        print("item 3")
    end
end

function exitButtonEvent(event)
    if ("ended" == event.phase) then
        composer.gotoScene("menu")
    end
end

function drawBackground()
    platformBG = display.newImage("images/fightScene/GrassBG.png")
    platformBG.width = display.pixelWidth
    platformBG.height = display.pixelHeight/2
    platformBG.x = display.pixelWidth - (display.pixelWidth/2)
    platformBG.y = display.pixelHeight - (display.pixelHeight/1.33) 

    local pokemon1 = pokemon:new({xPos=542, yPos=380})
    pokemon1:create(3)
    pokemon1:setSelectionView()

    local pokemon2 = pokemon:new({xPos=190, yPos=530})
    pokemon2:create(6)
    pokemon2:setBattleView()

    sceneGroup:insert( platformBG )
end

function returnToMainMenu(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (fightMenuBG) then
            fightMenuBG.isVisible = false
            for cnt = 0, #fightMenuBtn do
                fightMenuBtn[cnt].isVisible = false
            end
        end

        if (pkmnMenuBG) then
            pkmnMenuBG.isVisible = false
            for cnt = 0, #pkmnMenuBtn do
                pkmnMenuBtn[cnt].isVisible = false
            end
        end

        if (itemsMenuBG) then
            itemsMenuBG.isVisible = false
            for cnt = 0, #itemList do
                itemList[cnt].isVisible = false
            end
        end

        cancelBtn.isVisible = false

        mainMenuBG.isVisible = true
        for cnt = 0, 3 do
            mainMenuBtn[cnt].isVisible = true
        end
    end
end

function openMainMenu ()
    mainMenuBG = display.newImage("images/fightScene/menu/main/mainMenuBG.png")
    mainMenuBG.width = display.pixelWidth
    mainMenuBG.height = display.pixelHeight/2

    mainMenuBtn[0] = widget.newButton({    
            id = "fightBtn",
            label = "FIGHT",    
            labelColor = { default={ 0, 0, 0 }, over={ 0, 1, 1, 0.5 } },
            width = 220,
            height = 270,
            fontSize = 40,
            defaultFile = "images/fightScene/menu/main/FightButton.png",
            overFile  = "images/fightScene/menu/main/FightButtonOnClick.png",
            onEvent = openFightMenu 
        } )
    mainMenuBtn[0].x = 240
    mainMenuBtn[0].y = 828

    mainMenuBtn[1] = widget.newButton({    
            id = "PkmnBtn",
            label = "PKMN",    
            labelColor = { default={ 0, 0, 0 }, over={ 0, 1, 1, 0.5 } },
            width = 220,
            height = 270,
            fontSize = 40,
            defaultFile = "images/fightScene/menu/main/BagButton.png",
            overFile  = "images/fightScene/menu/main/BagButtonOnClick.png",
            onEvent = openPokemonMenu 
        } )
    mainMenuBtn[1].x = 475
    mainMenuBtn[1].y = 828

    mainMenuBtn[2] = widget.newButton({    
            id = "itemsBtn",
            label = "Items",    
            labelColor = { default={ 0, 0, 0 }, over={ 0, 1, 1, 0.5 } },
            width = 220,
            height = 270,
            fontSize = 40,
            defaultFile = "images/fightScene/menu/main/PokemonButton.png",
            overFile  = "images/fightScene/menu/main/PokemonButtonOnClick.png",
            onEvent = openItemsMenu 
        } )
    mainMenuBtn[2].x = 240
    mainMenuBtn[2].y = 1105


    mainMenuBtn[3] = widget.newButton({    
            id = "quitBtn",
            label = "Quit",    
            labelColor = { default={ 0, 0, 0 }, over={ 0, 1, 1, 0.5 } },
            width = 220,
            height = 270,
            fontSize = 40,
            defaultFile = "images/fightScene/menu/main/RunButton.png",
            overFile  = "images/fightScene/menu/main/RunButtonOnClick.png",
            onEvent = exitButtonEvent 
        } )
    mainMenuBtn[3].x = 475
    mainMenuBtn[3].y = 1105    

    mainMenuBG.x = display.pixelWidth - (display.pixelWidth/2)
    mainMenuBG.y = display.pixelHeight - (display.pixelHeight/4) 

    sceneGroup:insert( mainMenuBG )
    sceneGroup:insert( mainMenuBtn[0] )
    sceneGroup:insert( mainMenuBtn[1] )
    sceneGroup:insert( mainMenuBtn[2] )
    sceneGroup:insert( mainMenuBtn[3] )
end

function openFightMenu (event)

    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        fightMenuBG = display.newImage("images/fightScene/menu/fight/fightMenuBG.png")
        fightMenuBG.width = display.pixelWidth
        fightMenuBG.height = display.pixelHeight/2
        fightMenuBG.x = display.pixelWidth - (display.pixelWidth/2)
        fightMenuBG.y = display.pixelHeight - (display.pixelHeight/4) 

        fightMenuBtn[0] = widget.newButton({    
            id = "attack1Btn",
            width = 333,
            height = 206,
            defaultFile = "images/fightScene/menu/fight/fightMenuBtn.png",
            overFile  = "images/fightScene/menu/fight/fightMenuBtnOnClick.png",
            onEvent = attack1 
        } )        
        fightMenuBtn[0].x = 184
        fightMenuBtn[0].y = 842        

        fightMenuBtn[1] = widget.newButton({    
            id = "attack2Btn",
            width = 333,
            height = 206,
            defaultFile = "images/fightScene/menu/fight/fightMenuBtn.png",
            overFile  = "images/fightScene/menu/fight/fightMenuBtnOnClick.png",
            onEvent = attack2 
        } )        
        fightMenuBtn[1].x = 536
        fightMenuBtn[1].y = 842

        fightMenuBtn[2] = widget.newButton({    
            id = "attack3Btn",
            width = 333,
            height = 206,
            defaultFile = "images/fightScene/menu/fight/fightMenuBtn.png",
            overFile  = "images/fightScene/menu/fight/fightMenuBtnOnClick.png",
            onEvent = attack3 
        } )        
        fightMenuBtn[2].x = 184
        fightMenuBtn[2].y = 1074    

        fightMenuBtn[3] = widget.newButton({    
            id = "attack4Btn",
            width = 333,
            height = 206,
            defaultFile = "images/fightScene/menu/fight/fightMenuBtn.png",
            overFile  = "images/fightScene/menu/fight/fightMenuBtnOnClick.png",
            onEvent = attack4 
        } )      
        fightMenuBtn[3].x = 536
        fightMenuBtn[3].y = 1074        

        cancelBtn = widget.newButton({    
                id = "cancelBtn",
                width = 150,
                height = 75,
                defaultFile = "images/fightScene/menu/cancelBtn.png",
                overFile  = "images/fightScene/menu/cancelBtnOnClick.png",
                onEvent = returnToMainMenu 
            } )
        cancelBtn.x = 638
        cancelBtn.y = 1226    

        --fightMenuBtn[0]:addEventListener("tap", attack1);
        fightMenuBtn[1]:addEventListener("tap", attack2)
        fightMenuBtn[2]:addEventListener("tap", attack3)
        fightMenuBtn[3]:addEventListener("tap", attack4)

        mainMenuBG.isVisible = false
        for cnt = 0, 3 do
            mainMenuBtn[cnt].isVisible = false
        end

        sceneGroup:insert( fightMenuBG )
        sceneGroup:insert( fightMenuBtn[0] )
        sceneGroup:insert( fightMenuBtn[1] )
        sceneGroup:insert( fightMenuBtn[2] )
        sceneGroup:insert( fightMenuBtn[3] )
        sceneGroup:insert( cancelBtn )
    end
end

function openPokemonMenu(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        pkmnMenuBG = display.newImage("images/fightScene/menu/pkmn/pkmnMenuBG.png")
        pkmnMenuBG.width = display.pixelWidth
        pkmnMenuBG.height = display.pixelHeight/2 
        pkmnMenuBG.x = display.pixelWidth - (display.pixelWidth/2)
        pkmnMenuBG.y = display.pixelHeight - (display.pixelHeight/4)    

        pkmnMenuBtn[0] = widget.newButton({    
            id = "select1Btn",
            width = 355,
            height = 150,
            defaultFile = "images/fightScene/menu/pkmn/pkmnMenuBtn.png",
            overFile  = "images/fightScene/menu/pkmn/pkmnMenuBtnOnClick.png",
            onEvent = select1 
        } )        
        pkmnMenuBtn[0].x = 180
        pkmnMenuBtn[0].y = 716  

        pkmnMenuBtn[1] = widget.newButton({    
            id = "select2Btn",
            width = 355,
            height = 150,
            defaultFile = "images/fightScene/menu/pkmn/pkmnMenuBtn.png",
            overFile  = "images/fightScene/menu/pkmn/pkmnMenuBtnOnClick.png",
            onEvent = select2 
        } )        
        pkmnMenuBtn[1].x = 540
        pkmnMenuBtn[1].y = 752 

        pkmnMenuBtn[2] = widget.newButton({    
            id = "select3Btn",
            width = 355,
            height = 150,
            defaultFile = "images/fightScene/menu/pkmn/pkmnMenuBtn.png",
            overFile  = "images/fightScene/menu/pkmn/pkmnMenuBtnOnClick.png",
            onEvent = select3 
        } )        
        pkmnMenuBtn[2].x = 180
        pkmnMenuBtn[2].y = 887 

        pkmnMenuBtn[3] = widget.newButton({    
            id = "select4Btn",
            width = 355,
            height = 150,
            defaultFile = "images/fightScene/menu/pkmn/pkmnMenuBtn.png",
            overFile  = "images/fightScene/menu/pkmn/pkmnMenuBtnOnClick.png",
            onEvent = select4 
        } )        
        pkmnMenuBtn[3].x = 540
        pkmnMenuBtn[3].y = 914 

        pkmnMenuBtn[4] = widget.newButton({    
            id = "select5Btn",
            width = 355,
            height = 150,
            defaultFile = "images/fightScene/menu/pkmn/pkmnMenuBtn.png",
            overFile  = "images/fightScene/menu/pkmn/pkmnMenuBtnOnClick.png",
            onEvent = select5 
        } )        
        pkmnMenuBtn[4].x = 180
        pkmnMenuBtn[4].y = 1047 

        pkmnMenuBtn[5] = widget.newButton({    
            id = "select6Btn",
            width = 355,
            height = 150,
            defaultFile = "images/fightScene/menu/pkmn/pkmnMenuBtn.png",
            overFile  = "images/fightScene/menu/pkmn/pkmnMenuBtnOnClick.png",
            onEvent = select6 
        } )        
        pkmnMenuBtn[5].x = 540
        pkmnMenuBtn[5].y = 1074 

        cancelBtn = widget.newButton({    
                id = "cancelBtn",
                width = 150,
                height = 75,
                defaultFile = "images/fightScene/menu/cancelBtn.png",
                overFile  = "images/fightScene/menu/cancelBtnOnClick.png",
                onEvent = returnToMainMenu 
            } )
        cancelBtn.x = 638
        cancelBtn.y = 1226  

        mainMenuBG.isVisible = false
        for cnt = 0, 3 do
            mainMenuBtn[cnt].isVisible = false
        end

        sceneGroup:insert( pkmnMenuBG )
        sceneGroup:insert( pkmnMenuBtn[0] )
        sceneGroup:insert( pkmnMenuBtn[1] )
        sceneGroup:insert( pkmnMenuBtn[2] )
        sceneGroup:insert( pkmnMenuBtn[3] )        
        sceneGroup:insert( pkmnMenuBtn[4] ) 
        sceneGroup:insert( pkmnMenuBtn[5] ) 
        sceneGroup:insert( cancelBtn )
    end
end

function openItemsMenu (event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        itemsMenuBG = display.newImage("images/fightScene/menu/item/itemMenuBG.png")
        itemsMenuBG.width = display.pixelWidth
        itemsMenuBG.height = display.pixelHeight/2
        itemsMenuBG.x = display.pixelWidth - (display.pixelWidth/2)
        itemsMenuBG.y = display.pixelHeight - (display.pixelHeight/4)    


        itemList = {}
        itemList[0] = widget.newButton({    
            id = "item1",
            width = 350,
            height = 40,
            label = "Item 1",    
            labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
            fontSize = 30,
            defaultFile = "images/menuScene/menuBtn.png",
            overFile  = "images/menuScene/menuBtnOnClick.png",
            onEvent = item1 
        } )        
        itemList[0].x = 515
        itemList[0].y = 750 
        
        itemList[1] = widget.newButton({    
            id = "item2",
            width = 350,
            height = 40,
            label = "Item 2",    
            labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
            fontSize = 30,
            defaultFile = "images/menuScene/menuBtn.png",
            overFile  = "images/menuScene/menuBtnOnClick.png",
            onEvent = item2 
        } )        
        itemList[1].x = 515
        itemList[1].y = 800 

        itemList[2] = widget.newButton({    
            id = "item3",
            width = 350,
            height = 40,
            label = "Item 3",    
            labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
            fontSize = 30,
            defaultFile = "images/menuScene/menuBtn.png",
            overFile  = "images/menuScene/menuBtnOnClick.png",
            onEvent = item3 
        } )        
        itemList[2].x = 515
        itemList[2].y = 850         

        cancelBtn = widget.newButton({    
                id = "cancelBtn",
                width = 150,
                height = 75,
                defaultFile = "images/fightScene/menu/cancelBtn.png",
                overFile  = "images/fightScene/menu/cancelBtnOnClick.png",
                onEvent = returnToMainMenu 
            } )
        cancelBtn.x = 638
        cancelBtn.y = 1226  

        mainMenuBG.isVisible = false
        for cnt = 0, 3 do
            mainMenuBtn[cnt].isVisible = false
        end   

        sceneGroup:insert( itemsMenuBG )
        for cnt = 0, #itemList do
            sceneGroup:insert( itemList[cnt] )
        end
        sceneGroup:insert( cancelBtn ) 
    end
end

function openRunMenu (event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        cancelBtn = widget.newButton({    
                id = "cancelBtn",
                width = 150,
                height = 75,
                defaultFile = "images/fightScene/menu/cancelBtn.png",
                overFile  = "images/fightScene/menu/cancelBtnOnClick.png",
                onEvent = returnToMainMenu 
            } )
        cancelBtn.x = 638
        cancelBtn.y = 1226  

        mainMenuBG.isVisible = false
        for cnt = 0, 3 do
            mainMenuBtn[cnt].isVisible = false
        end      

        sceneGroup:insert( cancelBtn ) 
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