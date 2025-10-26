extends Control


func _ready() -> void:
    resized.connect(_resized)
    
func _resized() -> void:
    %LogFileList.resize()