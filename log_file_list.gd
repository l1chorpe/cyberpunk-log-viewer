extends ItemList

# Stores all log files
var _log_files: Array[LogFile] = []

func _ready() -> void:
    item_selected.connect(_item_selected)
    resized.connect(resize)
    item_activated.connect(func(_index): %ViewLogButton.pressed.emit())

func _item_selected(_index: int) -> void:
    %ViewLogButton.disabled = false

func resize() -> void:
    # Maintains a constant height
    custom_minimum_size.y = .8 * get_viewport_rect().size.y
    

func find_all_log_files(cyberpunk_directory: String) -> void:
    # Limit search to relevant dirs
    # Can be unlocked to full game root dir if necessary, as Δ(t) = ~6ms
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
    for log_file in _log_files:
        add_item(log_file.filename)

func get_selected_item() -> LogFile:
    # This is fine because only one element can be selected
    return _log_files[get_selected_items()[0]]