extends AcceptDialog

var info_text := "": set = _set_info_text

@onready var _label: RichTextLabel = $MarginContainer/RichTextLabel

func _set_info_text(value: String) -> void:
	info_text = value
	_label.bbcode_enabled = true
	_label.text = value


func _ready():
	visible = false


func _on_InfoDialog_confirmed():
	get_tree().paused = false


func show_modal() -> void:
	get_tree().paused = true
	show()
	




func _on_close_requested():
	_on_InfoDialog_confirmed()
