extends "res://scenes/rooms/room.gd"

@onready var _west_pedistal = $Node2D/WestBallPedistal
@onready var _east_pedistal = $Node2D/EastBallPedistal
@onready var _north_room_exit := $NorthRoomExit


func _how_many_things_needed_to_unlock() -> int:
	var count := 0
	if !_west_pedistal.triggered:
		count += 1
	if !_east_pedistal.triggered:
		count += 1
	if !InventoryMgr.has_item(InventoryMgr.InventoryItems.KEY):
		count += 1
	
	return count


func _on_NorthRoomExit_locked_room_exit_interacted_with(_room_exit):
	var things_needed_count = _how_many_things_needed_to_unlock()
	if things_needed_count == 0:
		_north_room_exit.locked = false
		InventoryMgr.remove_item(InventoryMgr.InventoryItems.KEY)
		return
	var plural = "s" if things_needed_count > 1 else ""
	var msg = "You still need to do %d thing%s to unlock this door." % [things_needed_count, plural]
	_hud.show_message(msg)

