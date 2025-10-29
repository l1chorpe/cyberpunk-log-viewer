extends Control


func _ready() -> void:
    resized.connect(_resized)
    _load_settings()
    
func _resized() -> void:
    %LogFileList.resize()

func _load_settings() -> void:
    # Skip "locate directory" step if the game path has been stored
    if Settings.default_game_path != "":
        $DirectorySelection/DirectoryPicker.dir_selected.emit(Settings.default_game_path)
    
    # Switch search mode according to stored settings
    %ToggleFullSearch.button_pressed = Settings.default_search_mode == Settings.SearchMode.FULL

func _notification(what: int) -> void:
    # Save settings on close
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        Settings.save_settings()
        get_tree().quit()