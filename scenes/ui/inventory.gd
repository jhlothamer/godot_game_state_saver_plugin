extends HBoxContainer

var _slot_class = preload("res://scenes/ui/inventory_slot.tscn")


func _ready():
	InventoryMgr.connect("inventory_updated", Callable(self, "_on_InventoryMgr_inventory_updated"))


func _on_InventoryMgr_inventory_updated():
	pass
	for c in get_children():
		c.queue_free()
	for item_id in InventoryMgr.inventory_items:
		var slot = _slot_class.instantiate()
		add_child(slot)
