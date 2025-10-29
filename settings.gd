class_name Settings

const SETTINGS_FILE_PATH = "user://clv-settings.cfg"

static var settings = ConfigFile.new()

static var default_game_path: String


static func _static_init() -> void:
    if FileAccess.file_exists(SETTINGS_FILE_PATH):
        _load_settings()
    else:
        _create_settings()

static func save_settings() -> void:
    settings.set_value("Main", "default_game_path", default_game_path)
    settings.save(SETTINGS_FILE_PATH)

static func _load_settings() -> void:
    settings.load(SETTINGS_FILE_PATH)
    default_game_path = settings.get_value("Main", "default_game_path")

static func _create_settings() -> void:
    default_game_path = ""