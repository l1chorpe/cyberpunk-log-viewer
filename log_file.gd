# Stores a file's name and location.
class_name LogFile extends Node

var filename: String
var directory: String
var full_path: String

func _init(file_name: String, file_directory: String) -> void:
    filename = file_name
    directory = file_directory
    full_path = directory + "/" + filename