extends Node
## Autoload that let's the GameStateService know when the TransitionMgr autoload is about
## to change scenes


func _ready() -> void:
	if OK != TransitionMgr.scene_transitioning.connect(_on_scene_transitioning):
		printerr("TransitionMgrGameStateHelperBridge: cant connect to scene_transitioning")


func _on_scene_transitioning(new_scene_path) -> void:
	GameStateService.on_scene_transitioning(new_scene_path)
