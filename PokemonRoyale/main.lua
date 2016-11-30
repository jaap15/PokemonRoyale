-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Authors: Daniel Burris, Jairo Arreola, John Mullen, and Zachary Johnson
--
-- This is our main function. Its only function is to take us into the menu scene.
-- The game plays like a normal pokemon game, but with a small twist to it. The pokemon
-- that you get to battle with are generated randomly in sets of 3 and you get to pick who 
-- you battle with. You will then be taking on 3 different enemy trainers to see if you
-- can beat them all. You will have items at your disposal, the ability to swap pokemon
-- in and out of combat without them taking damage, and advanced pokemeon fight mechanics
-- like super effective and not very effective damage modifiers. 
-----------------------------------------------------------------------------------------

-- Composer object is used for the creation and manipulation of scenes
local composer = require("composer")

-- Default code, hiding the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Only thing main.lua does is push us into the menu scene, all other functions are 
-- carried out in their respective scenes
composer.gotoScene("menu")