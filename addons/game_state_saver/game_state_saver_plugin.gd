@tool
extends EditorPlugin


const GAME_STATE_SERVICE_PATH = "res://addons/game_state_saver/game_state_service.gd"
const GAME_STATE_SERVICE_AUTLOAD_NAME = "GameStateService"

const GAME_STATE_INSPECTOR_PLUGIN = "res://addons/game_state_saver/game_sate_inspector.gd"
var _gamestateinspector_plugin : GameStateInspector 

func _enter_tree() -> void:
	_gamestateinspector_plugin = load(GAME_STATE_INSPECTOR_PLUGIN).new()
	add_inspector_plugin(_gamestateinspector_plugin)

func _exit_tree() -> void:
	remove_inspector_plugin(_gamestateinspector_plugin)


func _enable_plugin() -> void:
	add_autoload_singleton(GAME_STATE_SERVICE_AUTLOAD_NAME, GAME_STATE_SERVICE_PATH)


func _disable_plugin() -> void:
	remove_autoload_singleton(GAME_STATE_SERVICE_AUTLOAD_NAME)
