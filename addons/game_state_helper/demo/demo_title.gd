extends Control


@onready var _continue_btn:Button = %ContinueGameBtn


func _ready() -> void:
	_continue_btn.disabled = !FileAccess.file_exists(GameStateHelperDemoConsts.SAVE_GAME_FILE)
	if _continue_btn.disabled:
		_continue_btn.tooltip_text = "Game has not been saved yet to continue"


func _on_new_game_btn_pressed() -> void:
	GameStateService.new_game()
	get_tree().change_scene_to_file(GameStateHelperDemoConsts.DEMO_SCENE_1)


func _on_continue_game_btn_pressed() -> void:
	GameStateService.load_game_state(GameStateHelperDemoConsts.SAVE_GAME_FILE, _change_scene)


func _change_scene(scene_file_path:String) -> void:
	get_tree().change_scene_to_file(scene_file_path)


func _on_see_save_file_btn_pressed() -> void:
	var save_game_path := ProjectSettings.globalize_path(GameStateHelperDemoConsts.SAVE_GAME_FILE)
	OS.shell_show_in_file_manager(save_game_path)


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
