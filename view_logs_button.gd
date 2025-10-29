extends Button


func _ready() -> void:
    pressed.connect(_button_pressed)

func _button_pressed() -> void:
    # Hide directory selection window
    %DirectorySelection.hide()

    # Set persistent default path
    Settings.default_game_path = %DirectoryName.text
    
    # Retrieve all log files and update the displayed list
    %LogFileList.find_all_log_files(%DirectoryName.text, %ToggleFullSearch.button_pressed)
    %LogFileList.update_displayed()
    
    # Show list of log files
    %LogFileListContainer.show()
