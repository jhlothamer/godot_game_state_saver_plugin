extends "res://scenes/rooms/room.gd"

@onready var _bouncers_parent: Node2D = $Node2D/Bouncers
@onready var _spawn_ref_rect: ReferenceRect = $CanvasLayer/SpawnMarginContainer/SpawnAreaReferenceRect


var _bouncer_scene = preload("res://scenes/bouncer/bouncer.tscn")


func _ready():
	super._ready()
	$Node2D/AddBouncerFloorTrigger.connect("pressed", Callable(self, "_add_bouncer"))
	$Node2D/RemoveBouncerFloorTrigger.connect("pressed", Callable(self, "_remove_bouncer"))


func _get_spawn_position() -> Vector2:
	var spawn_position = _spawn_ref_rect.size * Vector2(randf(), randf())
	spawn_position += _spawn_ref_rect.position
	return spawn_position


func _add_bouncer():
	var bouncer = _bouncer_scene.instantiate()
	_bouncers_parent.call_deferred("add_child", bouncer)
	bouncer.position = _get_spawn_position()
	bouncer.current_direction = Vector2.RIGHT.rotated(randf()*2.0*PI)
#	bouncer.modulate = Color.from_hsv(randf(), 1.0, 1.0, 1.0)


func _remove_bouncer():
	if _bouncers_parent.get_child_count() == 0:
		return
	var bouncer_to_remove_index = randi() % _bouncers_parent.get_child_count()
	_bouncers_parent.get_child(bouncer_to_remove_index).queue_free()


