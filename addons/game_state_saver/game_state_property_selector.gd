class_name GameStatePropertySelector
extends EditorProperty

var option_button := OptionButton.new()
var parent_node: Node
var game_state_helper : GameStateHelper
var search_bar := LineEdit.new()

var button := Button.new()
var popup := PopupPanel.new()
var list := ItemList.new()
var all_props: Array[String] = []

func setup(_game_state_helper: Node)  -> void:
	game_state_helper = _game_state_helper
	parent_node = _game_state_helper.get_parent()
	_refresh_property_list()

func _init() -> void:
	self.name_split_ratio = 0
	add_child(button)
	add_focusable(button)
	button.text = "+++ Add Property +++"
	button.add_theme_color_override("font_color", Color(0, 0.8, 0))
	
	button.pressed.connect(_on_button_pressed)
	
	# Setup Popup UI
	var vbox : VBoxContainer = VBoxContainer.new()
	search_bar.placeholder_text = "Filter properties..."
	search_bar.text_changed.connect(_on_search_changed)
	
	list.custom_minimum_size = Vector2(200, 600)
	list.item_selected.connect(_on_item_selected)
	
	vbox.add_child(search_bar)
	vbox.add_child(list)
	popup.add_child(vbox)
	add_child(popup)
	
func _refresh_property_list() -> void:
	all_props.clear()
	if not parent_node: return
	
	for prop in parent_node.get_property_list():
		if prop.usage & PROPERTY_USAGE_EDITOR:
			if prop.name not in game_state_helper.save_properties:
				all_props.append(prop.name)
	_update_list("")
		
func _on_search_changed(new_text: String) -> void:
	_update_list(new_text)

func _update_list(filter: String) -> void:
	list.clear()
	for p_name in all_props:
		if filter == "" or filter.to_lower() in p_name.to_lower():
			list.add_item(p_name)
				
func _on_button_pressed() -> void:
	_refresh_property_list()
	popup.popup_on_parent(Rect2(button.global_position + Vector2(0, button.size.y), Vector2(button.size.x, 300)))
	_update_list(search_bar.text)
	search_bar.grab_focus()
	search_bar.select_all()
	

func _on_item_selected(index: int) -> void:
	var selected_name : String = list.get_item_text(index)
	game_state_helper.save_properties.append(selected_name)
	emit_changed("save_properties",selected_name)
	#search_bar.text = ""
	popup.hide()
	
