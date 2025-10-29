class_name Settings

const SETTINGS_FILE_PATH = "user://clv-settings.cfg"

static var settings = ConfigFile.new()

enum SearchMode {PARTIAL, FULL}

static var default_game_path: String
static var default_search_mode: SearchMode


static func _static_init() -> void:
    if FileAccess.file_exists(SETTINGS_FILE_PATH):
        _load_settings()
    else:
        _create_settings()

static func save_settings() -> void:
    settings.set_value("Main", "default_game_path", default_game_path)
    settings.set_value("Main", "default_search_mode", default_search_mode)

    settings.save(SETTINGS_FILE_PATH)

static func _load_settings() -> void:
    settings.load(SETTINGS_FILE_PATH)

    default_game_path = settings.get_value("Main", "default_game_path", "")
    default_search_mode = settings.get_value("Main", "default_search_mode", SearchMode.PARTIAL)

static func _create_settings() -> void:
    default_game_path = ""
    default_search_mode = SearchMode.PARTIAL