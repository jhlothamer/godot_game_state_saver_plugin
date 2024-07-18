extends MarginContainer

@export_file("*.tscn") var other_demo_scene_file_path := GameStateSaverDemoConsts.DEMO_SCENE_1
@export var other_demo_scene_name := "Demo 1"

@onready var _other_scene_btn:Button = %OtherSceneBtn


func _ready() -> void:
	_other_scene_btn.text = "Go To %s" % other_demo_scene_name


func _switch_scene(scene_file:String) -> void:
	GameStateService.save_game_state(GameStateSaverDemoConsts.SAVE_GAME_FILE)
	## NOTE:
	## demo is calling save_game_state on every scene switch
	## which is unusual.  Normally you would only call on_scene_transitioning().
	## Also note that save_game_state() calls on_scene_transitioning(),
	## and that calling both functions in your code can cause issues.
	#GameStateService.on_scene_transitioning()
	get_tree().change_scene_to_file(scene_file)


func _on_main_menu_btn_pressed() -> void:
	_switch_scene(GameStateSaverDemoConsts.DEMO_SCENE_TITLE)


func _on_other_scene_btn_pressed() -> void:
	_switch_scene(other_demo_scene_file_path)


func _on_dynamic_demo_btn_pressed() -> void:
	_switch_scene(GameStateSaverDemoConsts.DEMO_SCENE_DYNAMIC)


func _on_re_free_demo_btn_pressed() -> void:
	_switch_scene(GameStateSaverDemoConsts.DEMO_SCENE_REFREE)
