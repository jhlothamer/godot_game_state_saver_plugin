class_name InteractableArea2D
extends Area2D

signal InteractionStarted(interactable:Node2D, interactor:Node2D)
signal InteractionIndicatorStateChanged(interactable:Node2D, indicator_visible:bool)

@export var enabled := true
@export var limit_interaction_to_groups := false
@export var limit_interaction_groups:Array[String] = []


func _ready() -> void:
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


func toggle_interact_indicator(show_indicator: bool, _body: Node2D) -> void:
	if !enabled:
		return
	InteractionIndicatorStateChanged.emit(get_parent(), show_indicator)


func start_interaction(interactor: Node) -> void:
	if !enabled:
		return
	InteractionStarted.emit(get_parent(), interactor)
