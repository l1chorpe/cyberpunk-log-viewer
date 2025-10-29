extends Control


func _ready() -> void:
    resized.connect(_resized)
    _load_settings()
    
func _resized() -> void:
    %LogFileList.resize()

func _load_settings() -> void:
    if Settings.default_game_path != "":
        $DirectorySelection/DirectoryPicker.dir_selected.emit(Settings.default_game_path)

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        Settings.save_settings()
        get_tree().quit()