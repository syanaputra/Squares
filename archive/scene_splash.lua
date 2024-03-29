---------------------------------------------------------------------------------
-- SPLASH SCENE
-- The first screen user see when opening the game
---------------------------------------------------------------------------------

local storyboard = require( "composer" )
local scene = storyboard.newScene()

local ASSET_FOLDER = "assets/"
local ASSET_FOLDER_SOUND = ASSET_FOLDER .. "sounds/"

local phone_width = display.contentWidth
local phone_height = display.contentHeight

local audio_menu_click = audio.loadSound( ASSET_FOLDER_SOUND .. "select_menu_click/menu_click.wav" )

local score = require( "score" )
local scoreText

---------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	local bg =  display.newImageRect( sceneGroup, ASSET_FOLDER .. "splash_bg.png", phone_width, phone_height )
	bg.x = phone_width/2
	bg.y = phone_height/2
	
	
	local highscore_container =  display.newImageRect( sceneGroup, ASSET_FOLDER .. "hiscore_banner.png", phone_width, 55 )
	highscore_container.x = phone_width/2
	highscore_container.y = phone_height/2 - 20
	
	scoreText = score.init({
		fontSize = 25,
		font = native.systemFont,
		x = phone_width/2 + 100,
		y = phone_height/2 - 20,
		maxDigits = 7,
		leadingZeros = false,
		filename = "scorefile.txt",
		align = "center",
		width = phone_width,
	})
	score.set(score.load())
	
	local btn_width = 780 / 4
	local btn_height = 300 / 4
	
	local play_btn =  display.newImageRect( sceneGroup, ASSET_FOLDER .. "splash_play_btn.png", btn_width, btn_height )
	play_btn.x = phone_width/2
	play_btn.y = phone_height/2 + 70
	play_btn:toFront()
	
	local credits_btn =  display.newImageRect( sceneGroup, ASSET_FOLDER .. "splash_credits_btn.png", btn_width, btn_height )
	credits_btn.x = phone_width/2
	credits_btn.y = phone_height/2 + 170
	credits_btn:toFront()
		
	local function onTap_scene_game( event )
		storyboard.gotoScene( "scene_game" )
		audio.play(audio_menu_click)
		return true
	end
	play_btn:addEventListener( "tap", onTap_scene_game )
	
	local function onTap_scene_credits( event )
		storyboard.gotoScene( "scene_credits" )
		audio.play(audio_menu_click)
		return true
	end
	credits_btn:addEventListener( "tap", onTap_scene_credits )
	
	bg:toBack()
end

function scene:show( event )
	local sceneGroup = self.view
	
	if(storyboard.getPrevious() ~= nil) then
		storyboard.purgeScene(storyboard.getSceneName("previous"))
		storyboard.removeScene(storyboard.getSceneName("previous"))
	end
	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
		phone_width = nil
		phone_height = nil
		ASSET_FOLDER = nil
		ASSET_FOLDER_SOUND = nil
		
		display.remove(scoreText)
		scoreText = nil
		audio_menu_click = nil
		
		audio.stop(1)
		audio.dispose()
	elseif phase == "did" then
		-- Called when the scene is now off screen

	end	
end


function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	phone_width = nil
	phone_height = nil
	ASSET_FOLDER = nil
	ASSET_FOLDER_SOUND = nil
	
	scoreText = nil
	score = nil
	audio_menu_click = nil
	
    audio.stop(1)
    audio.dispose()
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene