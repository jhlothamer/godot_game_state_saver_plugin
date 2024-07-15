extends Sprite2D

@onready var _interaction_indicator: Sprite2D = $key_interaction_indicator



func _on_InteractableArea2D_InteractionIndicatorStateChanged(_interactable:Node2D, indicator_visible: bool) -> void:
	_interaction_indicator.visible = indicator_visible


func _on_InteractableArea2D_InteractionStarted(_interactable:Node2D, _interactor:Node2D) -> void:
	InventoryMgr.add_item(InventoryMgr.InventoryItems.KEY)
	queue_free()
