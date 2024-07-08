extends AnimatedSprite2D


@export var floor_switch_resource: FloorSwitchResource

@onready var _interaction_indicator: Node2D = $InteractionIndicator

func _on_game_state_helper_loading_data(_data):
	if floor_switch_resource.triggered:
		play("switched")
	else:
		play("default")


func _on_interactable_area_interaction_indicator_state_changed(_interactable, indicator_visible):
	if floor_switch_resource.triggered:
		return
	_interaction_indicator.visible = indicator_visible


func _on_interactable_area_interaction_started(_interactable, _interactor):
	floor_switch_resource.triggered = true
	play("switched")
	_interaction_indicator.visible = false
