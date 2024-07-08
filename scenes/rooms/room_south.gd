extends "res://scenes/rooms/room.gd"


@onready var _release_key_switch := $Node2D/ReleaseKeyFloorSwitch
@onready var _key = $Node2D/Key
@onready var _key_end_pos: Marker2D = $KeyEndPosition


func _ready():
	super._ready()
	_release_key_switch.connect("switch_state_changed", Callable(self, "_on_ReleaseKeyFloorSwitch_switch_state_changed"))


func _on_ReleaseKeyFloorSwitch_switch_state_changed(_triggered_flag: bool) -> void:
	var end = _key_end_pos.global_position
	var tween = create_tween()
	tween.tween_property(_key, "global_position", end, 1.0).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.play()
