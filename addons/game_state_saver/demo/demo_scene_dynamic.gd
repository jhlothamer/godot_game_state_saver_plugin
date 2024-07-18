extends Control


const DYNAMIC_CHILD_SCENE = preload("res://addons/game_state_saver/demo/dynamic_child_scene.tscn")


@onready var _dynamic_child_scene_parent:Node2D = $DynamicChildSceneParent

var _spawn_bounds:Rect2


func _ready() -> void:
	_spawn_bounds = get_viewport_rect().grow(-100)
	_spawn_bounds.position += Vector2(50, 50)


func _get_spawn_point() -> Vector2:
	var pt := Vector2(randf() * _spawn_bounds.size.x, randf() * _spawn_bounds.size.y)
	pt += _spawn_bounds.position
	
	return pt


func _spawn_dynamic_child_scene() -> void:
	var child_scene :Node2D= DYNAMIC_CHILD_SCENE.instantiate()
	child_scene.global_position = _get_spawn_point()
	child_scene.global_rotation = randf() * TAU
	child_scene.modulate = Color.from_hsv(randf(), 1.0, 1.0, 1.0)
	_dynamic_child_scene_parent.add_child(child_scene)


func _free_dynamic_child_scene() -> void:
	var child_count := _dynamic_child_scene_parent.get_child_count()
	if child_count <= 0:
		return
	var child_index := randi() % child_count
	var child := _dynamic_child_scene_parent.get_child(child_index)
	child.queue_free()
	



func _on_add_dynamic_instance_btn_pressed() -> void:
	_spawn_dynamic_child_scene()


func _on_remove_dynamic_instance_btn_pressed() -> void:
	_free_dynamic_child_scene()
