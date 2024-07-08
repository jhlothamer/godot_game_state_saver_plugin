extends Area2D

@export var triggered := false: set = _set_triggered

@onready var _collision_shape: CollisionShape2D = $CollisionShape2D

func _set_triggered(value: bool):
	triggered = value
	if triggered:
		visible = false
		if _collision_shape:
			_collision_shape.set_deferred("disabled", true)


func _on_Checkpoint_body_entered(body):
	if body is Player:
		self.triggered = true
		_start_checkpoint_save()


func _start_checkpoint_save():
	self.triggered = true
	await RenderingServer.frame_post_draw
	var screenshot = get_viewport().get_texture().get_image()
	var thread := Thread.new()
	thread.start(Callable(self, "_save_thread_func").bind([screenshot, thread]))


func _send_autosave_event(on: bool):
	# there are far better ways to trigger this
	#   but this will do for a demo
	var event = InputEventAction.new()
	event.action = "autosave_on" if on else "autosave_off"
	event.button_pressed = true
	Input.parse_input_event(event)


func _save_thread_func(data: Array) -> void:
	_send_autosave_event(true)
	var screenshot: Image = data[0]
	SaveGameDlg.save_checkpoint(screenshot)
	_send_autosave_event(false)

