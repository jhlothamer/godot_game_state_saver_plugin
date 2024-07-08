extends Sprite2D

@onready var _interaction_indicator: Sprite2D = $key_interaction_indicator



func _on_InteractableArea2D_InteractionIndicatorStateChanged(_interactable, indicator_visible):
	_interaction_indicator.visible = indicator_visible


func _on_InteractableArea2D_InteractionStarted(_interactable, _interactor):
	InventoryMgr.add_item(InventoryMgr.InventoryItems.KEY)
	queue_free()
