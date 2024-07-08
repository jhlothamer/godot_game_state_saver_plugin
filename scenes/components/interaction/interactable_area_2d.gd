class_name InteractableArea2D
extends Area2D

signal InteractionStarted(interactable, interactor)
signal InteractionIndicatorStateChanged(interactable, indicator_visible)

@export var enabled := true
@export var limit_interaction_to_groups := false
@export var limit_interaction_groups:Array[String] = []

var _interaction_areas := []
var _previous_global_position := Vector2.INF

func _ready():
	add_to_group("interactable")

func can_interact_with(interactor: CharacterBody2D) -> bool:
	if !enabled:
		return false
	
	if !limit_interaction_to_groups:
		return true
	for limit_interaction_group in limit_interaction_groups:
		if interactor.is_in_group(limit_interaction_group):
			return true
	return false


func toggle_interact_indicator(show_indicator: bool, _body) -> void:
	if !enabled:
		return
	emit_signal("InteractionIndicatorStateChanged", get_parent(), show_indicator)


func start_interaction(interactor: Node) -> void:
	if !enabled:
		return
	emit_signal("InteractionStarted", get_parent(), interactor)


func _physics_process(_delta):
	if _previous_global_position != global_position:
		_previous_global_position = global_position
		for interaction_area in _interaction_areas:
			interaction_area.interactable_has_moved(self)

