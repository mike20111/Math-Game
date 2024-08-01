extends Node

var save_path = "user://variable.save"

var test_scene_pb : int
var difficulty = 0

func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(test_scene_pb)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		test_scene_pb = file.get_var(test_scene_pb)

func _ready():
	print(test_scene_pb)
	load_data()
	print(test_scene_pb)

