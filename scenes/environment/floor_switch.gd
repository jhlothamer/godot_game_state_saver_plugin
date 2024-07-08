extends AnimatedSprite2D


signal switch_state_changed(triggered_flag)


const SPRITE_ANIM_TRIGGERED = "switched"
const SPRITE_ANIM_NOT_TRIGGERED = "default"


@export var trigger_id := ""


var triggered := false: set = _set_triggered


@onready var _interaction_indicator: AnimatedSprite2D = $InteractionIndicator


func _set_triggered(value: bool) -> void:
	triggered = value
	if _interaction_indicator:
		var anim_name = SPRITE_ANIM_TRIGGERED if value else SPRITE_ANIM_NOT_TRIGGERED
		play(anim_name)
		_interaction_indicator.play(anim_name)


func _ready():
	_interaction_indicator.visible = false
	_set_triggered(triggered)


func _on_InteractableArea2D_InteractionIndicatorStateChanged(_interactable, indicator_visible):
	#once switched/triggered, there's no going back
	if triggered:
		return
	_interaction_indicator.visible = indicator_visible


func _on_InteractableArea2D_InteractionStarted(_interactable, _interactor):
	#once switched/triggered, there's no going back
	if triggered:
		return
	_interaction_indicator.visible = false
	self.triggered = true
	emit_signal("switch_state_changed", triggered)
	


func _on_GameStateHelper_loading_data(data):
	if trigger_id.is_empty():
		printerr("Floorswitch: unable to load data - no trigger id.  %s" % get_path())
		return
	if data.has(trigger_id):
		self.triggered = data[trigger_id]


func _on_GameStateHelper_saving_data(data):
	if trigger_id.is_empty():
		printerr("Floorswitch: unable to save data - no trigger id.  %s" % get_path())
		return
	data[trigger_id] = triggered
