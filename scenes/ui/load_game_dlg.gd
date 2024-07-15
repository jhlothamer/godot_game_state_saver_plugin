extends ConfirmationDialog


@onready var _item_list: ItemList = $MarginContainer/HBoxContainer/ItemList
@onready var _texture_rect: TextureRect = $MarginContainer/HBoxContainer/TextureRect


func _ready() -> void:
	visible = false


func _get_saved_game_files() -> Array[String]:
	var dir := DirAccess.open(SaveGameDlg.SAVE_GAME_FOLDER)
	if dir == null:
		return []
	dir.list_dir_begin()
	var files:Array[String] = []
	var file_name := dir.get_next()
	while !file_name.is_empty():
		if file_name.ends_with(".json"):
			files.append(file_name.get_basename())
		file_name = dir.get_next()

	files.sort()
	files.reverse()
	return files

func _refresh_list() -> void:
	_item_list.clear()
	var files := _get_saved_game_files()
	for file:String in files:
		_item_list.add_item(file)
	if _item_list.get_item_count() > 0:
		_item_list.select(0)
		_on_ItemList_item_selected(0)

func show_modal() -> void:
	_refresh_list()
	popup_centered()


func _on_ItemList_item_selected(index:int) -> void:
	var base_file_name := _item_list.get_item_text(index)
	var image_file_name := SaveGameDlg.SAVE_GAME_FOLDER + "/" + base_file_name + ".png"
	#var image = load(image_file_name)
	var image := Image.new()
	image.load(image_file_name)
	var texture := ImageTexture.new()
	texture.set_image(image)
	_texture_rect.texture = texture


func _on_LoadGameDlg_confirmed() -> void:
	var selected := _item_list.get_selected_items()
	if selected:
		var index:int = selected[0]
		var base_file_name := _item_list.get_item_text(index)
		var save_file_name := SaveGameDlg.SAVE_GAME_FOLDER + "/" + base_file_name + ".json"
		var scene_file := GameStateService.load_game_state(save_file_name)
		if !scene_file:
			return
		TransitionMgr.transition_to(scene_file)

