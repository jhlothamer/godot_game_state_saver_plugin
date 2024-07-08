extends "res://scenes/rooms/room.gd"

@onready var _low_wall := $LowWall


func _on_RemoveBarrierFloorSwitch_switch_state_changed(triggered_flag: bool) -> void:
	if _low_wall != null and triggered_flag:
		_low_wall.queue_free()
