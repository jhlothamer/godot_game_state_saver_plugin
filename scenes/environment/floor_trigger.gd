extends Area2D


signal pressed()


enum StatesFrames {
	UP,
	MID,
	DOWN
}


@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_FloorTrigger_body_entered(body:Node2D) -> void:
	if body is Player:
		_animated_sprite.frame = StatesFrames.DOWN
		emit_signal("pressed")


func _on_FloorTrigger_body_exited(body:Node2D) -> void:
	if body is Player:
		_animated_sprite.frame = StatesFrames.UP
