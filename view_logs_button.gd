extends Button


func _ready() -> void:
    pressed.connect(_button_pressed)

func _button_pressed() -> void:
    # Hide directory selection window
    %DirectorySelection.hide()

    _set_persistent_settings()
    
    # Retrieve all log files and update the displayed list
    %LogFileList.find_all_log_files(%DirectoryName.text, %ToggleFullSearch.button_pressed)
    %LogFileList.update_displayed()
    
    # Show list of log files
    %LogFileListContainer.show()

func _set_persistent_settings() -> void:
    # Set persistent default path
    Settings.default_game_path = %DirectoryName.text
    # Set persistent default search mode
    if %ToggleFullSearch.button_pressed:
        Settings.default_search_mode = Settings.SearchMode.FULL
    else:
        Settings.default_search_mode = Settings.SearchMode.PARTIAL