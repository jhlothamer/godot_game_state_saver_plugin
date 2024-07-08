extends CanvasLayer

signal scene_transitioning(new_scene_path)

@onready var _fade_animation:AnimationPlayer = $fadeAnimation


var _starting_bus_volume: float
var _for_anim_db = 1.0 :
	get:
		return _for_anim_db # TODOConverter40 Non existent get function 
	set(mod_value):
		_for_anim_db = mod_value
var _scene_path := ""
var _animation_speed := 1.0
var _do_volume_anim := false
var _mute_bus_volume := -80.0
var _default_speed := .5


func set_for_anim_db(value: float) -> void:
	_for_anim_db = value
	if _do_volume_anim:
		AudioServer.set_bus_volume_db(0, _mute_bus_volume - _for_anim_db*(_mute_bus_volume - _starting_bus_volume))


func transition_to(scene_path: String, speed_seconds:float = -1.0, include_sound = false):
	if speed_seconds <= 0.0:
		speed_seconds = _default_speed
	_scene_path = scene_path
	_animation_speed = 2.0 / speed_seconds
	_do_volume_anim = include_sound
	_starting_bus_volume = AudioServer.get_bus_volume_db(0)
	_fade_animation.play("fadeOut", -1, _animation_speed)
	


func _on_fade_animation_animation_finished(anim_name):
	if anim_name == "fadeOut":
		scene_transitioning.emit(_scene_path)
		var results = get_tree().change_scene_to_file(_scene_path)
		if results != OK:
			printerr("TransitionMgr: could not change to scene '%s'" % _scene_path)
			return
		get_tree().paused = false
		_fade_animation.play("fadeIn", -1, _animation_speed)
