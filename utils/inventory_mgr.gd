extends Node


signal inventory_updated()


enum InventoryItems {
	KEY = 1
}


var inventory_items:Array[int] = []

func _ready() -> void:
	GameStateService.new_game_state_initialized.connect(_on_new_game_state_initialized)


func add_item(item_id: int) -> void:
	inventory_items.append(item_id)
	emit_signal("inventory_updated")


func remove_item(item_id: int) -> void:
	inventory_items.erase(item_id)
	emit_signal("inventory_updated")


func has_item(item_id: int) -> bool:
	return inventory_items.has(item_id)



func _on_GameStateHelper_loading_data(_data:Dictionary) -> void:
	emit_signal("inventory_updated")

func _on_new_game_state_initialized() -> void:
	inventory_items.clear()
