class_name BallPedistal
extends StaticBody2D


@export var trigger_id := ""
@export var triggered_color := Color.WHITE


var triggered := false


@onready var _ball: Sprite2D = $ball


func _on_GameStateHelper_loading_data(data:Dictionary) -> void:
	triggered = data[trigger_id] if data.has(trigger_id) else false
	if !triggered:
		return
	_ball.self_modulate = triggered_color
	triggered = true
