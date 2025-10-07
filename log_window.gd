class_name LogWindow extends Window


func _ready() -> void:
    close_requested.connect(_close_requested)

func with_data(file: LogFile) -> LogWindow:
    title = file.filename
    $TextArea.text = FileAccess.open(file.full_path, FileAccess.READ).get_as_text()
    return self

func _close_requested() -> void:
    queue_free()
