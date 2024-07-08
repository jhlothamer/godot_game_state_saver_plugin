class_name Hud
extends CanvasLayer


@onready var _info_dlg: AcceptDialog = $InfoDialog
@onready var _game_state_dlg: AcceptDialog = $RawGameStateDlg
@onready var _msg_label: Label = $MessageLabel
@onready var _msg_timer: Timer = $MessageTimer
@onready var _auto_save_icon: TextureRect = $AutoSaveMarginContainer/AutoSaveTextureRect
@onready var _auto_save_animation_player: AnimationPlayer = $AutoSaveMarginContainer/AutoSaveAnimationPlayer

func _ready():
	_auto_save_icon.visible = false


func show_info_dlg(info_text: String) -> void:
	_info_dlg.info_text = info_text
	_info_dlg.show_modal()


func show_message(msg: String) -> void:
	_msg_label.text = msg
	_msg_timer.start()


func _on_ViewGameStateBtn_pressed():
	_game_state_dlg.show_modal()


func _on_MessageTimer_timeout():
	_msg_label.text = ""


func _input(event):
	# there are far better ways to trigger this
	#   but this will do for a demo
	if event.is_action("autosave_on"):
		_auto_save_icon.visible = true
	if event.is_action("autosave_off"):
		# play animation to give player time to see the disk
		#  (some systems are so fast it doesn't have time to appear)
		_auto_save_animation_player.play("disk_exit")



func _on_AutoSaveAnimationPlayer_animation_finished(anim_name):
	if anim_name == "RESET":
		return
	_auto_save_icon.visible = false
	_auto_save_animation_player.play("RESET")
