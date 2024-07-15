class_name InteractionArea2D
extends Area2D

@export var enabled := true: set = _set_enabled

var _interactable_objects_nearby:Array[InteractableObject] = []
var _previous_global_position: Vector2 = Vector2.INF


class InteractableObject:
	func _init(_obj: Area2D) ->void:
		obj = _obj
	var obj: Area2D
	var distance_from_player_sq: float
	func calc_distance_from(current_player_position: Vector2) -> void:
		if obj == null or !is_instance_valid(obj):
			distance_from_player_sq = INF
			return
		distance_from_player_sq = current_player_position.distance_squared_to(obj.global_position)


class InteractablObjectSorter:
	static func sort(a: InteractableObject, b: InteractableObject) -> bool:
		if a.distance_from_player_sq < b.distance_from_player_sq:
			return true
		return false

func _ready() -> void:
	connect("area_entered", Callable(self, "_on_interactionArea_area_entered"))
	connect("area_exited", Callable(self, "_on_interactionArea_area_exited"))


func _set_enabled(value: bool) -> void:
	enabled = value
	if !enabled:
		for o in _interactable_objects_nearby:
			o.obj.toggle_interact_indicator(false, get_parent())
		_interactable_objects_nearby.clear()


func _add_interactable_object(obj:Area2D) -> void:
	_interactable_objects_nearby.append(InteractableObject.new(obj))
	_update_interactable_indicators()


func _remove_interactable_object(obj:Area2D) -> void:
	for io in _interactable_objects_nearby:
		if io.obj == obj:
			_interactable_objects_nearby.erase(io)
			obj.toggle_interact_indicator(false, get_parent())
			break
	_update_interactable_indicators()


func _update_interactable_indicators() -> void:
	_update_interactable_objects()
	for i in range(_interactable_objects_nearby.size()-1, -1, -1):
#		print("interaction area toggling interact indicator to " + str(i == 0))
		_interactable_objects_nearby[i].obj.toggle_interact_indicator(i == 0, get_parent())


func get_closest_interactable_object() -> Area2D:
	if _interactable_objects_nearby.size() < 1:
		return null
	return _interactable_objects_nearby[0].obj

func _update_interactable_objects() -> void:
	if _interactable_objects_nearby.size() < 2:
		return
	for io in _interactable_objects_nearby:
		io.calc_distance_from(global_position)
		
	_interactable_objects_nearby.sort_custom(Callable(InteractablObjectSorter, "sort"))


func _on_interactionArea_area_entered(area:Area2D) -> void:
	if !enabled:
		return
	if area.is_in_group("interactable"):
		if area.can_interact_with(get_parent()):
			_add_interactable_object(area)


func _on_interactionArea_area_exited(area:Area2D) -> void:
	if !enabled:
		return
	if area.is_in_group("interactable"):
		_remove_interactable_object(area)


func _physics_process(_delta:float) -> void:
	if _previous_global_position != global_position:
		_previous_global_position = global_position
		_update_interactable_indicators()


func start_interaction_with_closest_interactable_object(interactor: Node) -> bool:
	var closest_interactable := get_closest_interactable_object()
	if !closest_interactable:
		return false
	
	closest_interactable.start_interaction(interactor)
	return true


func interactable_has_moved(interactable_area: Area2D) -> void:
	for i in range(_interactable_objects_nearby.size()):
		var io:InteractableObject = _interactable_objects_nearby[i]
		if io.obj == interactable_area:
			io.calc_distance_from(global_position)
			break
	_update_interactable_indicators()


