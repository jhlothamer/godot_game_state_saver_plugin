@tool
class_name RoomExit
extends StaticBody2D


signal room_exit_triggered()
signal locked_room_exit_interacted_with(room_exit)


@export var enabled := true: set = _set_enabled
@export var locked := false: set = _set_locked
@export_file("*.tscn","*.scn")  var destination_level_scene := ""


@onready var _door: Sprite2D = $room_exit/door
@onready var _player_enter_position: Marker2D = $PlayerEnterPosition
@onready var _door_interact_indicator: Sprite2D = $room_exit/door_interact_indicator
@onready var _room_exit: Sprite2D = $room_exit


func _set_enabled(value: bool) -> void:
	enabled = value
	if _room_exit != null:
		_room_exit.visible = value


func _set_locked(value: bool) -> void:
	locked = value
	if _door != null:
		_door.visible = value
		set_collision_layer_value(1, value)
		set_collision_mask_value(1, value)


func _ready():
	_set_locked(locked)
	_set_enabled(enabled)
	if !enabled or locked:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
	elif enabled and !locked:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)


func get_player_enter_position() -> Vector2:
	return _player_enter_position.global_position


func _on_ExitDetectArea_body_entered(body):
	if !body is Player:
		return
	if destination_level_scene.is_empty():
		return
	emit_signal("room_exit_triggered")
	#keep player from moving any further during transition
	body.disabled = true
	TransitionMgr.transition_to(destination_level_scene)


func _on_InteractableArea2D_InteractionIndicatorStateChanged(_interactable, indicator_visible):
	if !locked or !enabled:
		return
	_door_interact_indicator.visible = indicator_visible


func _on_InteractableArea2D_InteractionStarted(_interactable, _interactor):
	if !locked or !enabled:
		return
	emit_signal("locked_room_exit_interacted_with", self)
