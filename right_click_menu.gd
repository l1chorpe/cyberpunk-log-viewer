extends Control

var _target_log_file: LogFile


func _ready() -> void:
    focus_exited.connect(_focus_exited)
    
    $VBoxContainer/CopyFolderPathButton.pressed.connect(_copy_folder_path_button_pressed)
    $VBoxContainer/CopyFilePathButton.pressed.connect(_copy_file_path_button_pressed)
    $VBoxContainer/OpenWithButton.pressed.connect(_open_with_button_pressed)
    $VBoxContainer/OpenWithSelector.file_selected.connect(_file_selected)
    $VBoxContainer/OpenWithSelector.canceled.connect(_open_with_canceled)

    # Fit the background size to the size of the container
    $Background.custom_minimum_size = size

func _copy_folder_path_button_pressed() -> void:
    # Copy to clipboard and hide
    DisplayServer.clipboard_set(_target_log_file.directory)
    hide()
    _return_focus_to_parent()

func _copy_file_path_button_pressed() -> void:
    # Copy to clipboard and hide
    DisplayServer.clipboard_set(_target_log_file.full_path)
    hide()
    _return_focus_to_parent()

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
    _return_focus_to_parent()

func _focus_exited() -> void:
    # Wait for next frame because focus_exited can trigger before a child's focus_entered
    await get_tree().process_frame
    # Only hide if no children have focus
    if not _child_has_focus():
        hide()

func _child_has_focus() -> bool:
    # Check if any of the children have focus
    for child in $VBoxContainer.get_children():
        if child is Control and child.has_focus():
            return true
    return false

func _open_with_canceled() -> void:
    grab_focus()

func _return_focus_to_parent() -> void:
    get_parent().grab_focus()
