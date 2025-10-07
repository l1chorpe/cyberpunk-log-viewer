extends Button


func _ready() -> void:
    pressed.connect(_button_pressed)

func _button_pressed() -> void:
    # Hide directory selection window
    %DirectorySelection.visible = false
    
    # Retrieve all log files and update the displayed list
    %LogFileList.find_all_log_files(%DirectoryName.text)
    %LogFileList.update_displayed()
    
    # Show list of log files
    %LogFileListContainer.visible = true
