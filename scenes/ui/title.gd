extends Control

@onready var _load_game_dlg:ConfirmationDialog = $LoadGameDlg


func _on_NewGameBtn_pressed() -> void:
	GameStateService.new_game()
	TransitionMgr.transition_to("res://scenes/rooms/room_main.tscn")


func _on_LoadGameBtn_pressed() -> void:
	_load_game_dlg.show_modal()


func _on_ExitBtn_pressed() -> void:
	get_tree().quit()
