@tool
extends EditorPlugin


const GAME_STATE_SERVICE_PATH = "res://addons/game_state_helper/game_state_service.gd"
const GAME_STATE_SERVICE_AUTLOAD_NAME = "GameStateService"


func _enable_plugin():
	add_autoload_singleton(GAME_STATE_SERVICE_AUTLOAD_NAME, GAME_STATE_SERVICE_PATH)


func _disable_plugin():
	remove_autoload_singleton(GAME_STATE_SERVICE_AUTLOAD_NAME)
