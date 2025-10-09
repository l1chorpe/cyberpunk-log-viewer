extends Control


func _ready() -> void:
    resized.connect(_resized)
    
func _resized() -> void:
    %LogFileList.resize()

func _gui_input(event: InputEvent):
    # "Steal" focus when clicked on
    if(event is InputEventMouseButton):
        %LogFileList.focus_exited.emit()