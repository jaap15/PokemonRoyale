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
local pkmnMenuBG
local fightMenuBG
local itemsMenuBG
local pkmnHB = {}
local pkmnDB = {}
local pokemonThumbNails = {}
local pokemonNames = {}
local pokemon = Pokemon:new( {HP=150} )
local sceneGroup
local currentPokemon = 1;
local eCurrentPokemon = 1;
local currentEnemy = 1;
local fSize = 45; --font size
local trainer = composer.getVariable("trainer")
local infoBoxText = display.newText("", 0, 0, native.systemFont, 28)
local trainersAvailable = composer.getVariable("trainersAvailable")
local pSelected = false;
local eSelected = false;
local moveMadeTimer;
local resultText;

-- Local Sounds
local menuClick = audio.loadStream("sounds/menuButtonClick.mp3")
local summonSound = audio.loadStream("sounds/summon.wav")

local function updatePokemonInfoBox()
    infoBoxText.pName.text = string.format("%s Lv:100", trainer.Pokemans[currentPokemon].pokemon.tag)
    infoBoxText.eName.text = string.format("%s Lv:100", enemyList[currentEnemy].E_Pokemans[enemyList[currentEnemy].currentPokemon].pokemon.tag)
    infoBoxText.pHpText.text = string.format("%03d/%03d", trainer.Pokemans[currentPokemon].pokemon.currentHP, trainer.Pokemans[currentPokemon].pokemon.maxHP)
 end

function drawBackground()
    
    trainer:throwAnimation()
    enemyList[currentEnemy]:beginBattle()

    enemyInfoBox = display.newImage("images/fightScene/enemyInfoBox.png")
    enemyInfoBox.width = display.contentWidth/2
    enemyInfoBox.height = display.contentHeight /10
    enemyInfoBox.x = (display.contentWidth + 200) - display.contentWidth
    enemyInfoBox.y = (display.contentHeight  + 100) - display.contentHeight

    infoBoxText.eName = display.newText(" ", 0, 0, native.systemFont, 28)
    infoBoxText.eName:setTextColor(0, 0, 0)
    infoBoxText.eName.x = (display.contentWidth + 200) - display.contentWidth
    infoBoxText.eName.y = (display.contentHeight  + 75) - display.contentHeight

    sceneGroup:insert( animation )

    playerInfoBox = display.newImage("images/fightScene/playerInfoBox.png")
    playerInfoBox.width = display.contentWidth/2
    playerInfoBox.height = display.contentHeight/10  
    playerInfoBox.x = display.contentWidth - 200
    playerInfoBox.y = display.contentHeight/2 - 100

    infoBoxText.pName = display.newText(" ", 0, 0, native.systemFont, 28)
    infoBoxText.pName:setTextColor(0, 0, 0)
    infoBoxText.pName.x = display.contentWidth - 200
    infoBoxText.pName.y = display.contentHeight/2 - 125

    infoBoxText.pHpText = display.newText(" ", 0, 0, native.systemFont, 28)
    infoBoxText.pHpText:setTextColor(0, 0, 0)
    infoBoxText.pHpText.x = display.contentWidth - 200
    infoBoxText.pHpText.y = display.contentHeight/2 - 75

    for i = 1, #trainer.Pokemans do
        trainer.Pokemans[i]:drawHealthBar("player")
        enemyList[currentEnemy].E_Pokemans[i]:drawHealthBar("enemy")
    end

    local y1Offset = 0
    local y2Offset = 0
    for cnt = 1, #trainer.Pokemans do
        pkmnHB[cnt], pkmnDB[cnt] = trainer.Pokemans[cnt]:returnHealthStatus()
        if (cnt % 2 == 0) then
            pkmnHB[cnt].x = 550
            pkmnHB[cnt].y = 775+y1Offset
            pkmnDB[cnt].x = 550
            pkmnDB[cnt].y = 775+y1Offset                
            y1Offset = y1Offset+160
        else                
            pkmnHB[cnt].x = 200
            pkmnHB[cnt].y = 735+y2Offset
            pkmnDB[cnt].x = 200
            pkmnDB[cnt].y = 735+y2Offset                
            y2Offset = y2Offset + 170
        end
    end    

    local function drawEnemyPokemon()
        enemyList[currentEnemy].E_Pokemans[enemyList[currentEnemy].currentPokemon]:setSelectionView();
    end
    local enemySummon = summonPkmnAnimation(542,350)
    local function summonEnemy()
        enemySummon.isVisible = true
        enemySummon:play()
        local function hideAnimation()
            enemySummon.isVisible = false
        end
        timer.performWithDelay(500, hideAnimation)
    end
    timer.performWithDelay(2500, summonEnemy)
    timer.performWithDelay(3000, drawEnemyPokemon)
    
    local function drawPlayerPokemon()
        trainer.Pokemans[currentPokemon]:setBattleView()
        trainer.Pokemans[currentPokemon]:setPos(190,530)
        updatePokemonInfoBox()
    end
    local playerSummon = summonPkmnAnimation(190,530)
    local function summonPlayer()
        playerSummon.isVisible = true
        playerSummon:play()
        audio.play(summonSound, {loops = 0})
        local function hideAnimation()
            playerSummon.isVisible = false
        end
        timer.performWithDelay(500, hideAnimation)        
    end
    timer.performWithDelay(2500, summonPlayer)
    timer.performWithDelay(3000, drawPlayerPokemon)

    -- moveMadeTimer = timer.performWithDelay(100, moveMade)
    sceneGroup:insert( enemyList[currentEnemy].arena )
    sceneGroup:insert( enemyInfoBox )
    sceneGroup:insert( playerInfoBox )
    sceneGroup:insert( infoBoxText )
end


local function startBattle()
    timer.performWithDelay(2500, openMainMenu)
    timer.performWithDelay(1, drawBackground)
end

local function endBattle()
    timer.cancel(moveMadeTimer)
    enemyList[currentEnemy]:moveTrainerIn()
    trainer:moveTrainerIn()
end

local function enemyAttack(attackNumber)

end

local function result()
    
end

local function moveMade()
    if pSelected then

    end
end

-- Fight Menu Functions
function attack1(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        local nextButton;
        local nextButton2;
        local trainerWentFirst = false;

        enemyList[currentEnemy]:generateAttack(eCurrentPokemon);

        
        local ePname = enemyList[currentEnemy].E_Pokemans[eCurrentPokemon].pokemon.tag
        local eSpeed = enemyList[currentEnemy].E_Pokemans[eCurrentPokemon].pokemon.speed;
        local eAttackType = enemyList[currentEnemy].cAttack.AttackType
        local eAttackDamage = enemyList[currentEnemy].cAttack.AttackDamage
        local eAttackName = enemyList[currentEnemy].cAttack.AttackName

        local tPname = trainer.Pokemans[currentPokemon].pokemon.tag
        local tSpeed = trainer.Pokemans[currentPokemon].pokemon.speed;
        local tAttackType = trainer.Pokemans[currentPokemon].pokemon.attack1Type
        local tAttackDamage = trainer.Pokemans[currentPokemon].pokemon.attack1Damage;
        local tAttackName = trainer.Pokemans[currentPokemon].pokemon.attack1

        print("trainer speed: ".. tSpeed)
        print("enemy speed: " .. eSpeed)

        fightMenuBG.isVisible = false
        for cnt = 0, #fightMenuBtn do
            fightMenuBtn[cnt].isVisible = false
        end

        cancelBtn.isVisible = false

        resultText = display.newText("", 0, 0, native.systemFont, 35)
        resultText:setTextColor(1, 1, 1)
        resultText.x = display.contentWidth/2
        resultText.y = display.contentHeight/2  + 75

        if tSpeed >= eSpeed then
            trainerWentFirst = true;
            resultText.text = string.format("%s attacked with %s\n%s", tPname, tAttackName, enemyList[currentEnemy].E_Pokemans[eCurrentPokemon]:getEffective(tAttackType))

            enemyList[currentEnemy].E_Pokemans[eCurrentPokemon]:takeDamage(tAttackDamage, tAttackType)
        
        else
            trainerWentFirst = false;

            resultText.text = string.format("%s attacked with %s\n%s", ePname, eAttackName, trainer.Pokemans[currentPokemon]:getEffective(eAttackType))

            trainer.Pokemans[currentPokemon]:takeDamage(eAttackDamage, eAttackType)
        end
        
        updatePokemonInfoBox()

        local function removeLocalObjects()
            print("removing button")
            nextButton:removeSelf()
            nextButton = nil
            nextButton2:removeSelf()
            nextButton2 = nil
            print("removing text")
            resultText:removeSelf()
            resultText = nil
        end

        local function nextButtonEvent(event)
            if ("ended" == event.phase) then
                print("clicked next")
                audio.play(menuClick, {loops = 0})
                nextButton.isVisible = false;
                local function nextButton2Event(event)
                    if ("ended" == event.phase) then
                        print("clicked next")
                        audio.play(menuClick, {loops = 0})
                        timer.performWithDelay(10, removeLocalObjects)
                        returnAfterAttack()
                    end
                end

                nextButton2 = widget.newButton({    
                    id = "nextButton2",
                    label = "Next",    
                    labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
                    width = 300,
                    height = 60,
                    fontSize = 30,
                    defaultFile = "images/menuScene/menuBtn.png",
                    overFile  = "images/menuScene/menuBtnOnClick.png",
                    onEvent = nextButton2Event 
                } ) 

                nextButton2.x = display.contentCenterX
                nextButton2.y = display.contentCenterY+(display.contentCenterY/1.9)

                if trainerWentFirst then
                    resultText.text = string.format("%s attacked with %s\n%s", ePname, eAttackName, trainer.Pokemans[currentPokemon]:getEffective(eAttackType))

                    trainer.Pokemans[currentPokemon]:takeDamage(eAttackDamage, eAttackType)
                else
                    resultText.text = string.format("%s attacked with %s\n%s", tPname, tAttackName, enemyList[currentEnemy].E_Pokemans[eCurrentPokemon]:getEffective(tAttackType))

                    enemyList[currentEnemy].E_Pokemans[eCurrentPokemon]:takeDamage(tAttackDamage, tAttackType)

                end

                -- timer.performWithDelay(10, removeLocalObjects)
                updatePokemonInfoBox()
                -- returnAfterAttack()
            end
        end

        nextButton = widget.newButton({    
            id = "nextButton",
            label = "Next",    
            labelColor = { default={ 1, 1, 0 }, over={ 0, 1, 1, 0.5 } },
            width = 300,
            height = 60,
            fontSize = 30,
            defaultFile = "images/menuScene/menuBtn.png",
            overFile  = "images/menuScene/menuBtnOnClick.png",
            onEvent = nextButtonEvent 
        } ) 

        nextButton.x = display.contentCenterX
        nextButton.y = display.contentCenterY+(display.contentCenterY/1.9)


        -- -- trainer.Pokemans[currentPokemon]:takeDamage(25, "grass")
        -- enemyList[currentEnemy]:PokemonFainted(3)

    end
end

function attack2(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        enemyList[currentEnemy].E_Pokemans[enemyList[currentEnemy].currentPokemon]:takeDamage(trainer.Pokemans[currentPokemon].pokemon.attack2Damage, trainer.Pokemans[currentPokemon].pokemon.attack2Type)
        returnAfterAttack()
    end
end

function attack3(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        enemyList[currentEnemy].E_Pokemans[enemyList[currentEnemy].currentPokemon]:takeDamage(trainer.Pokemans[currentPokemon].pokemon.attack3Damage, trainer.Pokemans[currentPokemon].pokemon.attack3Type)
        returnAfterAttack()
    end
end

function attack4(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        enemyList[currentEnemy].E_Pokemans[enemyList[currentEnemy].currentPokemon]:takeDamage(trainer.Pokemans[currentPokemon].pokemon.attack4Damage,trainer.Pokemans[currentPokemon].pokemon.attack4Type)
        returnAfterAttack()
    end
end

function select1(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (currentPokemon == 1 or trainer.Pokemans[1].pokemon.status == "fainted") then

        else 
            native.showAlert("Are you sure?", "Switch out " .. trainer.Pokemans[currentPokemon].pokemon.tag .. " for " .. trainer.Pokemans[1].pokemon.tag .. "?", {"No", "Yes"}, pokemonSelect1Confirm)
        end
    end
end

function select2(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (currentPokemon == 2 or trainer.Pokemans[2].pokemon.status == "fainted") then

        else         
            native.showAlert("Are you sure?", "Switch out " .. trainer.Pokemans[currentPokemon].pokemon.tag .. " for " .. trainer.Pokemans[2].pokemon.tag .. "?", {"No", "Yes"}, pokemonSelect2Confirm)
        end
   end
end

function select3(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (currentPokemon == 3 or trainer.Pokemans[3].pokemon.status == "fainted") then

        else 
            native.showAlert("Are you sure?", "Switch out " .. trainer.Pokemans[currentPokemon].pokemon.tag .. " for " .. trainer.Pokemans[3].pokemon.tag .. "?", {"No", "Yes"}, pokemonSelect3Confirm)
        end
    end
end

function select4(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (currentPokemon == 4 or trainer.Pokemans[4].pokemon.status == "fainted") then

        else 
            native.showAlert("Are you sure?", "Switch out " .. trainer.Pokemans[currentPokemon].pokemon.tag .. " for " .. trainer.Pokemans[4].pokemon.tag .. "?", {"No", "Yes"}, pokemonSelect4Confirm)
        end
    end
end

function select5(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (currentPokemon == 5 or trainer.Pokemans[5].pokemon.status == "fainted") then

        else 
            native.showAlert("Are you sure?", "Switch out " .. trainer.Pokemans[currentPokemon].pokemon.tag .. " for " .. trainer.Pokemans[5].pokemon.tag .. "?", {"No", "Yes"}, pokemonSelect5Confirm)  
        end      
    end
end

function select6(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (currentPokemon == 6 or trainer.Pokemans[6].pokemon.status == "fainted") then

        else 
            native.showAlert("Are you sure?", "Switch out " .. trainer.Pokemans[currentPokemon].pokemon.tag .. " for " .. trainer.Pokemans[6].pokemon.tag .. "?", {"No", "Yes"}, pokemonSelect6Confirm) 
        end       
    end
end

function pokemonSelect1Confirm(event, pkmnIndex)
    if ( event.action == "clicked" ) then
        local i = event.index  
        if ( i == 1 ) then  

        elseif ( i == 2 ) then
            transition.to(trainer.Pokemans[currentPokemon].pokemon.battleView, {time = 1250, x = trainer.Pokemans[currentPokemon].pokemon.battleView.x-750})
            local function spawnNewPkmn()
                trainer.Pokemans[currentPokemon]:HidePokemon()  
                currentPokemon = 1
                updatePokemonInfoBox()
                trainer.Pokemans[currentPokemon]:setBattleView()
                trainer.Pokemans[currentPokemon]:setPos(190,530)
                returnAfterSwap()
            end
            local playerSummon = summonPkmnAnimation(190,530)
            local function summonPlayer()
                playerSummon.isVisible = true
                playerSummon:play()
                audio.play(summonSound, {loops = 0})
                local function hideAnimation()
                    playerSummon.isVisible = false
                end
                timer.performWithDelay(500, hideAnimation)        
            end
            timer.performWithDelay(500, summonPlayer)
            timer.performWithDelay(1000, spawnNewPkmn)
        end
    end
end

function pokemonSelect2Confirm(event, pkmnIndex)
    if ( event.action == "clicked" ) then
        local i = event.index  
        if ( i == 1 ) then  

        elseif ( i == 2 ) then
            transition.to(trainer.Pokemans[currentPokemon].pokemon.battleView, {time = 1250, x = trainer.Pokemans[currentPokemon].pokemon.battleView.x-750})
            local function spawnNewPkmn()
                trainer.Pokemans[currentPokemon]:HidePokemon()  
                currentPokemon = 2
                updatePokemonInfoBox()
                trainer.Pokemans[currentPokemon]:setBattleView()
                trainer.Pokemans[currentPokemon]:setPos(190,530)
                returnAfterSwap()
            end
            local playerSummon = summonPkmnAnimation(190,530)
            local function summonPlayer()
                playerSummon.isVisible = true
                playerSummon:play()
                audio.play(summonSound, {loops = 0})
                local function hideAnimation()
                    playerSummon.isVisible = false
                end
                timer.performWithDelay(500, hideAnimation)        
            end
            timer.performWithDelay(500, summonPlayer)            
            timer.performWithDelay(1000, spawnNewPkmn)
        end
    end
end

function pokemonSelect3Confirm(event, pkmnIndex)
    if ( event.action == "clicked" ) then
        local i = event.index  
        if ( i == 1 ) then  

        elseif ( i == 2 ) then
            transition.to(trainer.Pokemans[currentPokemon].pokemon.battleView, {time = 1250, x = trainer.Pokemans[currentPokemon].pokemon.battleView.x-750})
            local function spawnNewPkmn()
                trainer.Pokemans[currentPokemon]:HidePokemon()  
                currentPokemon = 3
                updatePokemonInfoBox()
                trainer.Pokemans[currentPokemon]:setBattleView()
                trainer.Pokemans[currentPokemon]:setPos(190,530)
                returnAfterSwap()
            end
            local playerSummon = summonPkmnAnimation(190,530)
            local function summonPlayer()
                playerSummon.isVisible = true
                playerSummon:play()
                audio.play(summonSound, {loops = 0})
                local function hideAnimation()
                    playerSummon.isVisible = false
                end
                timer.performWithDelay(500, hideAnimation)        
            end
            timer.performWithDelay(500, summonPlayer)
            timer.performWithDelay(1000, spawnNewPkmn)
        end
    end
end

function pokemonSelect4Confirm(event, pkmnIndex)
    if ( event.action == "clicked" ) then
        local i = event.index  
        if ( i == 1 ) then  

        elseif ( i == 2 ) then
            transition.to(trainer.Pokemans[currentPokemon].pokemon.battleView, {time = 1250, x = trainer.Pokemans[currentPokemon].pokemon.battleView.x-750})
            local function spawnNewPkmn()
                trainer.Pokemans[currentPokemon]:HidePokemon()  
                currentPokemon = 4
                updatePokemonInfoBox()
                trainer.Pokemans[currentPokemon]:setBattleView()
                trainer.Pokemans[currentPokemon]:setPos(190,530)
                returnAfterSwap()
            end
            local playerSummon = summonPkmnAnimation(190,530)
            local function summonPlayer()
                playerSummon.isVisible = true
                playerSummon:play()
                audio.play(summonSound, {loops = 0})
                local function hideAnimation()
                    playerSummon.isVisible = false
                end
                timer.performWithDelay(500, hideAnimation)        
            end
            timer.performWithDelay(500, summonPlayer)
            timer.performWithDelay(1000, spawnNewPkmn)
        end
    end
end

function pokemonSelect5Confirm(event, pkmnIndex)
    if ( event.action == "clicked" ) then
        local i = event.index  
        if ( i == 1 ) then  

        elseif ( i == 2 ) then
            transition.to(trainer.Pokemans[currentPokemon].pokemon.battleView, {time = 1250, x = trainer.Pokemans[currentPokemon].pokemon.battleView.x-750})
            local function spawnNewPkmn()
                trainer.Pokemans[currentPokemon]:HidePokemon()  
                currentPokemon = 5
                updatePokemonInfoBox()
                trainer.Pokemans[currentPokemon]:setBattleView()
                trainer.Pokemans[currentPokemon]:setPos(190,530)
                returnAfterSwap()
            end
            local playerSummon = summonPkmnAnimation(190,530)
            local function summonPlayer()
                playerSummon.isVisible = true
                playerSummon:play()
                audio.play(summonSound, {loops = 0})
                local function hideAnimation()
                    playerSummon.isVisible = false
                end
                timer.performWithDelay(500, hideAnimation)        
            end
            timer.performWithDelay(500, summonPlayer)
            timer.performWithDelay(1000, spawnNewPkmn)
        end
    end
end

function pokemonSelect6Confirm(event, pkmnIndex)
    if ( event.action == "clicked" ) then
        local i = event.index  
        if ( i == 1 ) then  

        elseif ( i == 2 ) then
            transition.to(trainer.Pokemans[currentPokemon].pokemon.battleView, {time = 1250, x = trainer.Pokemans[currentPokemon].pokemon.battleView.x-750})
            local function spawnNewPkmn()
                trainer.Pokemans[currentPokemon]:HidePokemon()  
                currentPokemon = 6
                updatePokemonInfoBox()
                trainer.Pokemans[currentPokemon]:setBattleView()
                trainer.Pokemans[currentPokemon]:setPos(190,530)
                returnAfterSwap()
            end
            local playerSummon = summonPkmnAnimation(190,530)
            local function summonPlayer()
                playerSummon.isVisible = true
                playerSummon:play()
                audio.play(summonSound, {loops = 0})
                local function hideAnimation()
                    playerSummon.isVisible = false
                end
                timer.performWithDelay(500, hideAnimation)        
            end
            timer.performWithDelay(500, summonPlayer)
            timer.performWithDelay(1000, spawnNewPkmn)
        end
    end
end

-- Item Menu Functions
function item1(event)
        if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        print("item 1")
    end
end

function item2(event)
        if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        print("item 2")
    end
end

function item3(event)
        if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        print("item 3")
    end
end

function removeObject(objectName)
 
    if(objectName ~= nil) then
     objectName:removeSelf();
     objectName = nil;
    end
 
end

function exitButtonEvent(event)
    if ("ended" == event.phase) then
        audio.play(menuClick, {loops = 0})
        removeObject(infoBoxText.pName)
        removeObject(infoBoxText.eName)
        removeObject(infoBoxText.pHpText)
        removeObject(infoBoxText)
        removeObjectList(trainer.Pokemans, true);
        removeObjectList(enemyList[currentEnemy].E_Pokemans, true);
		enemyList[currentEnemy]:audioStop()
        composer.gotoScene("menu")
    end
end

function returnAfterAttack()
    fightMenuBG.isVisible = false
    for cnt = 0, #fightMenuBtn do
        fightMenuBtn[cnt].isVisible = false
    end

    cancelBtn.isVisible = false

    mainMenuBG.isVisible = true
    for cnt = 0, 3 do
        mainMenuBtn[cnt].isVisible = true
    end

    print(trainer.Pokemans[currentPokemon].pokemon.tag .. " has " .. trainer.Pokemans[currentPokemon].pokemon.status)
    if (trainer.Pokemans[currentPokemon].pokemon.status == "fainted") then
        print("FAINTED")
        local function swapToPokemonSelect(event)
            local i = event.index 
            if ( i == 1 ) then  
                openPokemonMenu() 
            end
        end
        native.showAlert("Pokemon has fainted",  trainer.Pokemans[currentPokemon].pokemon.tag .. " has fainted \n Select your next pokemon ", {"Go"}, openPokemonMenuFromAlertBox)
    end      
end

function summonPkmnAnimation(x,y)
    local sheetName = require("images.fightScene.animations.pkmnSummon")
    local spriteSheetData = sheetName:getSheet()
    --Creating the image sheet
    local battleSheet = graphics.newImageSheet( "images/fightScene/animations/pkmnSummon.png", spriteSheetData)
    --Getting the sequence data from the sprite sheet file
    local sequenceData = sheetName:getSequence()

    animation = display.newSprite( battleSheet, sequenceData)
    animation.x = x
    animation.y = y
    animation:scale(2,2)
    animation.isVisible = false

    return animation
end

function returnAfterSwap()
    pkmnMenuBG.isVisible = false
    for cnt = 0, #pkmnMenuBtn do
        pkmnMenuBtn[cnt].isVisible = false
    end 
    for cnt = 1, #trainer.Pokemans do       
        pokemonThumbNails[cnt].isVisible = false 
        pokemonNames[cnt].isVisible = false
        pkmnHB[cnt].isVisible = false
        pkmnDB[cnt].isVisible = false
    end

    cancelBtn.isVisible = false

    mainMenuBG.isVisible = true
    for cnt = 0, 3 do
        mainMenuBtn[cnt].isVisible = true
    end    
end

function returnToMainMenu(event)
    if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        if (fightMenuBG ~= nil) then
            fightMenuBG.isVisible = false
            for cnt = 0, #fightMenuBtn do
                print("fightMenuBtn elements  " .. #fightMenuBtn)
                fightMenuBtn[cnt].isVisible = false
            end
        end

        if (pkmnMenuBG ~= nil) then
            pkmnMenuBG.isVisible = false
            for cnt = 0, #pkmnMenuBtn do
                pkmnMenuBtn[cnt].isVisible = false
            end 
            for cnt = 1, #trainer.Pokemans do       
                pokemonThumbNails[cnt].isVisible = false 
                pokemonNames[cnt].isVisible = false
                pkmnHB[cnt].isVisible = false
                pkmnDB[cnt].isVisible = false
            end
        end

        if (itemsMenuBG ~= nil) then
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
    mainMenuBG.width = display.contentWidth
    mainMenuBG.height = display.contentHeight/2

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

    mainMenuBG.x = display.contentWidth - (display.contentWidth/2)
    mainMenuBG.y = display.contentHeight - (display.contentHeight/4) 

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
        fightMenuBG.width = display.contentWidth
        fightMenuBG.height = display.contentHeight/2
        fightMenuBG.x = display.contentWidth - (display.contentWidth/2)
        fightMenuBG.y = display.contentHeight - (display.contentHeight/4) 

        fightMenuBtn[0] = widget.newButton({    
            id = "attack1Btn",
            label = trainer.Pokemans[currentPokemon].pokemon.attack1,
            fontSize = fSize,
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
            label = trainer.Pokemans[currentPokemon].pokemon.attack2,
            fontSize = fSize,
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
            label = trainer.Pokemans[currentPokemon].pokemon.attack3,
            fontSize = fSize,
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
            label = trainer.Pokemans[currentPokemon].pokemon.attack4,
            fontSize = fSize,
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

        mainMenuBG.isVisible = false
        for cnt = 0, 3 do
            mainMenuBtn[cnt].isVisible = false
        end

        sceneGroup:insert( fightMenuBG )
        for cnt = 0, #fightMenuBtn do
            sceneGroup:insert(fightMenuBtn[cnt])
        end
        sceneGroup:insert( cancelBtn )
    end
end

function openPokemonMenu(event)
        if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        pkmnMenuBG = display.newImage("images/fightScene/menu/pkmn/pkmnMenuBG.png")
        pkmnMenuBG.width = display.contentWidth
        pkmnMenuBG.height = display.contentHeight/2 
        pkmnMenuBG.x = display.contentWidth - (display.contentWidth/2)
        pkmnMenuBG.y = display.contentHeight - (display.contentHeight/4)    


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

        -- Drawing pokemon thumbnails
        local y1Offset = 0
        local y2Offset = 0
        for cnt = 1, #trainer.Pokemans do
            pokemonThumbNails[cnt] = trainer.Pokemans[cnt]:returnSelectImage()
            pokemonThumbNails[cnt].isVisible = true
            if (cnt % 2 == 0) then
                pokemonThumbNails[cnt].x = 470
                pokemonThumbNails[cnt].y = 725+y1Offset
                y1Offset = y1Offset+160
            else                
                pokemonThumbNails[cnt].x = 100
                pokemonThumbNails[cnt].y = 685+y2Offset
                y2Offset = y2Offset + 170
            end
        end

        -- Drawing pokemon names
        local y1Offset = 0
        local y2Offset = 0
        for cnt = 1, #trainer.Pokemans do
            pokemonNames[cnt] = display.newText(trainer.Pokemans[cnt].pokemon.tag, 0, 0, native.systemFont, 30)
            if (cnt % 2 == 0) then
                pokemonNames[cnt].x = 600
                pokemonNames[cnt].y = 725+y1Offset
                y1Offset = y1Offset+160
            else                
                pokemonNames[cnt].x = 200
                pokemonNames[cnt].y = 685+y2Offset
                y2Offset = y2Offset + 170
            end
        end        
        
        -- Drawing pokemon hp bars
        for cnt = 1, #trainer.Pokemans do
            pkmnHB[cnt], pkmnDB[cnt] = trainer.Pokemans[cnt]:returnHealthStatus()
            pkmnHB[cnt].isVisible = true
            pkmnDB[cnt].isVisible = true
        end    

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
        for cnt = 0, #pkmnMenuBtn do
            sceneGroup:insert(pkmnMenuBtn[cnt])
        end 
        sceneGroup:insert( cancelBtn )
    end
end

function openPokemonMenuFromAlertBox()
    audio.play(menuClick, {loops = 0})
    pkmnMenuBG = display.newImage("images/fightScene/menu/pkmn/pkmnMenuBG.png")
    pkmnMenuBG.width = display.contentWidth
    pkmnMenuBG.height = display.contentHeight/2 
    pkmnMenuBG.x = display.contentWidth - (display.contentWidth/2)
    pkmnMenuBG.y = display.contentHeight - (display.contentHeight/4)    


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

    -- Drawing pokemon thumbnails
    local y1Offset = 0
    local y2Offset = 0
    for cnt = 1, #trainer.Pokemans do
        pokemonThumbNails[cnt] = trainer.Pokemans[cnt]:returnSelectImage()
        pokemonThumbNails[cnt].isVisible = true
        if (cnt % 2 == 0) then
            pokemonThumbNails[cnt].x = 470
            pokemonThumbNails[cnt].y = 725+y1Offset
            y1Offset = y1Offset+160
        else                
            pokemonThumbNails[cnt].x = 100
            pokemonThumbNails[cnt].y = 685+y2Offset
            y2Offset = y2Offset + 170
        end
        --sceneGroup:insert(pokemonThumbNails[cnt])
    end

    -- Drawing pokemon names
    local y1Offset = 0
    local y2Offset = 0
    for cnt = 1, #trainer.Pokemans do
        pokemonNames[cnt] = display.newText(trainer.Pokemans[cnt].pokemon.tag, 0, 0, native.systemFont, 30)
        if (cnt % 2 == 0) then
            pokemonNames[cnt].x = 600
            pokemonNames[cnt].y = 725+y1Offset
            y1Offset = y1Offset+160
        else                
            pokemonNames[cnt].x = 200
            pokemonNames[cnt].y = 685+y2Offset
            y2Offset = y2Offset + 170
        end
        --sceneGroup:insert(pokemonNames[cnt])
    end        
    
    -- Drawing pokemon hp bars
    for cnt = 1, #trainer.Pokemans do
        pkmnHB[cnt], pkmnDB[cnt] = trainer.Pokemans[cnt]:returnHealthStatus()
        pkmnHB[cnt].isVisible = true
        pkmnDB[cnt].isVisible = true
    end    

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
    for cnt = 0, #pkmnMenuBtn do
        sceneGroup:insert(pkmnMenuBtn[cnt])
    end 
    sceneGroup:insert( cancelBtn )
end

function openItemsMenu (event)
        if ( "ended" == event.phase ) then
        audio.play(menuClick, {loops = 0})
        itemsMenuBG = display.newImage("images/fightScene/menu/item/itemMenuBG.png")
        itemsMenuBG.width = display.contentWidth
        itemsMenuBG.height = display.contentHeight/2
        itemsMenuBG.x = display.contentWidth - (display.contentWidth/2)
        itemsMenuBG.y = display.contentHeight - (display.contentHeight/4)    


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
    --animation:play()
    sceneGroup:insert( animation )
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
	
    openingAnimations()
    trainer:create()

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
        startBattle();


        -- timer.performWithDelay(2000, endBattle)

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
        composer.removeScene("fight")

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