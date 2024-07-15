extends Sprite2D

signal info_requested(info_msg:String)


@export_multiline var bb_code_info_msg := "This is a default message."


@onready var _interact_indicator: Sprite2D = $info_interact_indicator


func _ready() -> void:
	_interact_indicator.visible = false


func _on_InteractableArea2D_InteractionIndicatorStateChanged(_interactable:Node2D, indicator_visible: bool) -> void:
	_interact_indicator.visible = indicator_visible


func _on_InteractableArea2D_InteractionStarted(_interactable: Node2D, _interactor:Node2D) -> void:
	info_requested.emit(bb_code_info_msg)
