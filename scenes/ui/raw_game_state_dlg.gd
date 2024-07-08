extends AcceptDialog

const ACTION_BUTTON_DUMP_TO_FILE = "DumpStateToFile"

@onready var _text_edit: TextEdit = $MarginContainer/TextEdit


func _ready():
	visible = false
	add_button("Dump State to File (see user://)", true, ACTION_BUTTON_DUMP_TO_FILE)
#	var close_btn = get_close_button()
#	close_btn.connect("pressed", Callable(self, "_on_RawGameStateDlg_confirmed"))


func show_modal() -> void:
	_text_edit.text = GameStateService.get_game_state_string(true)
	get_tree().paused = true
	popup_centered()


func _on_RawGameStateDlg_custom_action(action):
	if action == ACTION_BUTTON_DUMP_TO_FILE:
		GameStateService.dump_game_state()


func _on_RawGameStateDlg_confirmed():
	get_tree().paused = false


func _on_close_requested():
#	pass # Replace with function body.
	_on_RawGameStateDlg_confirmed()
