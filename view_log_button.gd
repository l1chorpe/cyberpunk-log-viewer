extends Button


@onready
var log_window := preload("uid://48vqlo40epw")

func _ready() -> void:
    pressed.connect(_button_pressed)

func _button_pressed() -> void:
    # Open log in a new, independent window
    %LogFileListContainer.add_child(
        log_window.instantiate().with_data(%LogFileList.get_selected_item())
    )