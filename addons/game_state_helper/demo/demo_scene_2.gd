extends Control


@onready var _polygon1:Polygon2D = $Polygon2D1
@onready var _polygon2:Polygon2D = $Polygon2D2


func _on_polygon_1_color_picker_btn_color_changed(color: Color) -> void:
	_polygon1.self_modulate = color


func _on_polygon_2_color_picker_btn_color_changed(color: Color) -> void:
	_polygon2.self_modulate = color


func _on_change_scene_btn_pressed() -> void:
	GameStateService.save_game_state(GameStateHelperDemoConsts.SAVE_GAME_FILE)
	GameStateService.on_scene_transitioning()
	get_tree().change_scene_to_file(GameStateHelperDemoConsts.DEMO_SCENE_1)


func _on_main_menu_btn_pressed() -> void:
	GameStateService.save_game_state(GameStateHelperDemoConsts.SAVE_GAME_FILE)
	GameStateService.on_scene_transitioning()
	get_tree().change_scene_to_file(GameStateHelperDemoConsts.DEMO_SCENE_TITLE)
