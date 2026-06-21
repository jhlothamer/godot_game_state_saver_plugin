class_name GameStateInspector
extends EditorInspectorPlugin

func _can_handle(object: Object) -> bool:
	return object is GameStateHelper


func _parse_property(object: Object, _type: Variant.Type, name: String, _hint_type: PropertyHint, _hint_string: String, _usage_flags: int, _wide: bool) -> bool:
	if name.begins_with("_add_property_editor"):
		var selector := GameStatePropertySelector.new(object)
		add_property_editor(name, selector, false, " ")
		return true
	return false
