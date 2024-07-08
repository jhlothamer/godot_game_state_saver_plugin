extends Control

@onready var _load_game_dlg = $LoadGameDlg


func _on_NewGameBtn_pressed():
	GameStateService.new_game()
	TransitionMgr.transition_to("res://scenes/rooms/room_main.tscn")


func _on_LoadGameBtn_pressed():
	_load_game_dlg.show_modal()


func _on_ExitBtn_pressed():
	get_tree().quit()
