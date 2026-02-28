class_name GameStatePropertySelector
extends EditorProperty

var _parent_node: Node
var _game_state_helper : GameStateHelper
var _search_bar := LineEdit.new()
var _button := Button.new()
var _popup := PopupPanel.new()
var _list := ItemList.new()
var _all_props: Array[String] = []

func setup(game_state_helper: Node)  -> void:
	_game_state_helper = game_state_helper
	_parent_node = game_state_helper.get_parent()
	_refresh_property_list()


func _init() -> void:
	if "name_split_ratio" in self: self.name_split_ratio = 0
	add_child(_button)
	add_focusable(_button)
	_button.text = "+++ Add Property +++"
	_button.add_theme_color_override("font_color", Color(0, 0.8, 0))
	
	_button.pressed.connect(_on_button_pressed)
	
	# Setup Popup UI
	var vbox : VBoxContainer = VBoxContainer.new()
	_search_bar.placeholder_text = "Filter properties..."
	_search_bar.text_changed.connect(_on_search_changed)
	
	_list.custom_minimum_size = Vector2(200, 600)
	_list.item_selected.connect(_on_item_selected)
	
	vbox.add_child(_search_bar)
	vbox.add_child(_list)
	_popup.add_child(vbox)
	add_child(_popup)


func _refresh_property_list() -> void:
	_all_props.clear()
	if not _parent_node: return
	
	for prop in _parent_node.get_property_list():
		if prop.usage & PROPERTY_USAGE_EDITOR:
			if prop.name not in _game_state_helper.save_properties:
				_all_props.append(prop.name)
	_all_props.sort()
	_update_list("")


func _on_search_changed(new_text: String) -> void:
	_update_list(new_text)


func _update_list(filter: String) -> void:
	_list.clear()
	for p_name in _all_props:
		if filter == "" or filter.to_lower() in p_name.to_lower():
			_list.add_item(p_name)


func _on_button_pressed() -> void:
	_refresh_property_list()
	_popup.popup_on_parent(Rect2(_button.global_position + Vector2(0, _button.size.y), Vector2(_button.size.x, 300)))
	_update_list(_search_bar.text)
	_search_bar.grab_focus()
	_search_bar.select_all()


func _on_item_selected(index: int) -> void:
	var selected_name : String = _list.get_item_text(index)
	_game_state_helper.save_properties.append(selected_name)
	emit_changed("save_properties",selected_name)
	_popup.hide()
	
