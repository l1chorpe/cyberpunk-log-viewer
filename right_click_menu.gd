extends Control

signal position_changed()


func _ready() -> void:
    position_changed.connect(_position_changed)

func _position_changed():
    # Somehow, without this, the root element doesn't scale up with the buttons
    var new_size: Vector2i = $VBoxContainer/CopyFolderPathButton.size
    set_size(Vector2(new_size.x * 1.05, new_size.y * 2.4))