extends ItemList

@onready
var right_click_menu := preload("uid://bbcd3icyndmcj")

# Stores all log files
var _log_files: Array[LogFile] = []

func _ready() -> void:
    item_selected.connect(_item_selected)
    resized.connect(resize)
    item_activated.connect(func(_index): %ViewLogButton.pressed.emit())
    item_clicked.connect(_item_clicked)

func _item_selected(_index: int) -> void:
    %ViewLogButton.disabled = false

func resize() -> void:
    # Maintains a constant height
    custom_minimum_size.y = .8 * get_viewport_rect().size.y
    

func find_all_log_files(cyberpunk_directory: String, full_search: bool) -> void:
    # Clear for when it is reloaded
    _log_files.clear()
    
    # If toggled, search through the whole game directory
    if full_search:
        _find_log_files_in(cyberpunk_directory)
        return

    # Otherwise only the specified
    var TARGET_DIRS: PackedStringArray = [
        cyberpunk_directory + "/bin/x64/plugins/cyber_engine_tweaks",
        cyberpunk_directory + "/r6/logs",
        cyberpunk_directory + "/red4ext/logs",
        cyberpunk_directory + "/red4ext/plugins"
    ]

    for dir in TARGET_DIRS:
        _find_log_files_in(dir)

func _find_log_files_in(directory: String) -> void:
    # If dir is empty, exit function
    var dir := DirAccess.open(directory)
    if !dir: return

    dir.list_dir_begin()
    var filename := dir.get_next()
    # Go through all files in dir and subdirs
    while filename != "":
        # Recursively go through subdirs
        if dir.current_is_dir():
            _find_log_files_in(directory + "/" + filename)
        # If filename ends with .log, save the path
        elif filename.ends_with(".log"):
            _log_files.append(LogFile.new(filename, directory))
        filename = dir.get_next()

func update_displayed() -> void:
    # Clear list for when it is reloaded
    clear()

    for log_file in _log_files:
        # Add the item and show the full path in the tooltip
        var item_index := add_item(log_file.filename)
        set_item_tooltip(item_index, log_file.full_path)

func get_selected_item() -> LogFile:
    # This is fine because only one element can be selected
    return _log_files[get_selected_items()[0]]

func _item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
    if mouse_button_index == MOUSE_BUTTON_RIGHT:
        # Make the context menu appear and give it focus and the targeted log file
        $RightClickMenu.set_target_log_file(_log_files[index])
        $RightClickMenu.set_optimal_position(at_position)
        $RightClickMenu.show()
        $RightClickMenu.grab_focus()
    else:
        # Grab focus again
        grab_focus()
