extends Control

@onready var _to_be_freed:Node = $ToBeFreedNode
@onready var _remove_x_btn:Button = $RemoveXBtn


func _on_remove_x_btn_pressed() -> void:
	if !is_instance_valid(_to_be_freed):
		return
	_to_be_freed.queue_free()


func _on_to_be_freed_node_tree_exited() -> void:
	_remove_x_btn.disabled = true
