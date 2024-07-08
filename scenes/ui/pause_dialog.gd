extends Control


signal pause_about_to_show()


@onready var _save_game_dlg = $SaveGame
@onready var _load_game_dlg = $LoadGameDlg

var _image_for_save: Image


func _ready():
	visible = false


func _on_ResumeBtn_pressed():
	_image_for_save = null
	hide()
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_PAUSABLE
	visible = false


func _on_SaveBtn_pressed():
	_save_game_dlg.show_save_dlg(_image_for_save)


func _on_LoadBtn_pressed():
	_load_game_dlg.show_modal()


func _on_MainMenuBtn_pressed():
	TransitionMgr.transition_to("res://scenes/ui/title.tscn")


func _show() -> void:
	_image_for_save = _get_screenshot()
	emit_signal("pause_about_to_show")
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	visible = true
	show()


func _input(event):
	if !event.is_action("pause") or event.is_echo() or !event.is_pressed():
		return
	if visible:
		_on_ResumeBtn_pressed()
	else:
		_show()


func _get_screenshot() -> Image:
	var image = get_viewport().get_texture().get_image()
	return image
