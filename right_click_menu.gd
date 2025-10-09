extends Control

signal position_changed()

var _target_log_file: LogFile


func _ready() -> void:
    position_changed.connect(_position_changed)

    $VBoxContainer/CopyFolderPathButton.pressed.connect(_copy_folder_path_button_pressed)
    $VBoxContainer/CopyFilePathButton.pressed.connect(_copy_file_path_button_pressed)

func _position_changed():
    # Somehow, without this, the root element doesn't scale up with the buttons
    var new_size: Vector2i = $VBoxContainer/CopyFolderPathButton.size
    set_size(Vector2(new_size.x * 1.05, new_size.y * 2.4))

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