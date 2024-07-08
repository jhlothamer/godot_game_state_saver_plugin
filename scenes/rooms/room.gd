extends Node2D

const ENTERING_ROOM_FROM_DIRECTION_STATE_KEY = "entering_room_from_direction"

 
@onready var _room_exit_by_direction := {
	"North": $NorthRoomExit,
	"South": $SouthRoomExit,
	"East": $EastRoomExit,
	"West": $WestRoomExit,
}


var _player_face_direction := {
	"North": Vector2.DOWN,
	"South": Vector2.UP,
	"East": Vector2.LEFT,
	"West": Vector2.RIGHT,
}


@onready var _player: Player = $Node2D/Player
@onready var _hud: Hud = $Hud


func _ready():
	# wait for game state load to finish
	await GameStateService.state_load_completed
	
	var enter_room_from_direction = GameStateService.get_global_state_value(ENTERING_ROOM_FROM_DIRECTION_STATE_KEY)
	if enter_room_from_direction == null or enter_room_from_direction == "":
		return
	
	#if we've entered from another room
	#then set player position
	var enter_room_exit: RoomExit = _room_exit_by_direction[enter_room_from_direction]
	_player.global_position = enter_room_exit.get_player_enter_position()
	_player.face_direction(_player_face_direction[enter_room_from_direction])
	
	#clear the enter direction - this way loading a save file will keep player in their saved position
	GameStateService.set_global_state_value(ENTERING_ROOM_FROM_DIRECTION_STATE_KEY, null)


func _on_NorthRoomExit_room_exit_triggered():
	GameStateService.set_global_state_value(ENTERING_ROOM_FROM_DIRECTION_STATE_KEY, "South")


func _on_SouthRoomExit_room_exit_triggered():
	GameStateService.set_global_state_value(ENTERING_ROOM_FROM_DIRECTION_STATE_KEY, "North")


func _on_EastRoomExit_room_exit_triggered():
	GameStateService.set_global_state_value(ENTERING_ROOM_FROM_DIRECTION_STATE_KEY, "West")


func _on_WestRoomExit_room_exit_triggered():
	GameStateService.set_global_state_value(ENTERING_ROOM_FROM_DIRECTION_STATE_KEY, "East")


func _on_Info_info_requested(info_msg):
	_hud.show_info_dlg(info_msg)


func _on_NorthRoomExit_locked_room_exit_interacted_with(_room_exit):
	pass # Replace with function body.

