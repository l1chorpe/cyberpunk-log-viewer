extends Button


func _ready() -> void:
    pressed.connect(_button_pressed)

func _button_pressed() -> void:
    %LogFileList.find_all_log_files(Settings.default_game_path, Settings.default_search_mode)
    %LogFileList.update_displayed()