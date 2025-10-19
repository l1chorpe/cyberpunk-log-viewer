extends FileDialog


func _ready() -> void:
    dir_selected.connect(_dir_selected)

func _dir_selected(path: String) -> void:
    # Update path label
    %DirectoryName.text = path
    # Update button text
    %ToggleDP.text = "Change directory"
    # Show "view logs" and "toggle full search" buttons
    %ViewLogsButton.visible = true
    %ToggleFullSearch.show()