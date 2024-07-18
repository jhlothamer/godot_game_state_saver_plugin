@tool
extends EditorPlugin


const GAME_STATE_SERVICE_PATH = "res://addons/game_state_saver/game_state_service.gd"
const GAME_STATE_SERVICE_AUTLOAD_NAME = "GameStateService"


func _enable_plugin() -> void:
	add_autoload_singleton(GAME_STATE_SERVICE_AUTLOAD_NAME, GAME_STATE_SERVICE_PATH)


func _disable_plugin() -> void:
	remove_autoload_singleton(GAME_STATE_SERVICE_AUTLOAD_NAME)
