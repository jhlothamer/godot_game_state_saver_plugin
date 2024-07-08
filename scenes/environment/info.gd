extends Sprite2D

signal info_requested(info_msg)


@export_multiline var bb_code_info_msg := "This is a default message."


@onready var _interact_indicator: Sprite2D = $info_interact_indicator


func _ready():
	_interact_indicator.visible = false


func _on_InteractableArea2D_InteractionIndicatorStateChanged(_interactable, indicator_visible):
	_interact_indicator.visible = indicator_visible


func _on_InteractableArea2D_InteractionStarted(_interactable, _interactor):
	emit_signal("info_requested", bb_code_info_msg)
