extends Control

var _target_log_file: LogFile


func _ready() -> void:
    $VBoxContainer/CopyFolderPathButton.pressed.connect(_copy_folder_path_button_pressed)
    $VBoxContainer/CopyFilePathButton.pressed.connect(_copy_file_path_button_pressed)
    $VBoxContainer/OpenWithButton.pressed.connect(_open_with_button_pressed)
    $VBoxContainer/OpenWithSelector.file_selected.connect(_file_selected)

    # Fit the background size to the size of the container
    $Background.custom_minimum_size = size

func _copy_folder_path_button_pressed() -> void:
    # Copy to clipboard and hide
    DisplayServer.clipboard_set(_target_log_file.directory)
    hide()

func _copy_file_path_button_pressed() -> void:
    # Copy to clipboard and hide
    DisplayServer.clipboard_set(_target_log_file.full_path)
    hide()

func set_target_log_file(log_file: LogFile) -> void:
    _target_log_file = log_file

func set_optimal_position(pos: Vector2) -> void:
    # Replace the context menu according to the boundaries to avoid clipping at the edges
    var log_file_list: ItemList = get_parent()
    if pos.x + size.x > log_file_list.size.x:
        pos.x -= size.x
    if pos.y + size.y > log_file_list.size.y:
        pos.y -= size.y
    set_position(pos)

func _open_with_button_pressed() -> void:
    $VBoxContainer/OpenWithSelector.show()

func _file_selected(path: String) -> void:
    # Open the log file in the specified program
    OS.create_process(path, [_target_log_file.full_path])
    hide()
