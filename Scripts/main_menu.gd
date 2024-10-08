extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var main_menu = $Main
@onready var stage_select = $StageSelect

var levels = ["res://tutorial.tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	Save.load_data()
	$"StageSelect/ScrollContainer/Control/StageContainer1/LevelContainer/Level 1/BestTimeLabel".text = "best time: " + str(Save.test_scene_pb)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		_go_main_menu()
		
	$Camera3D.global_rotation.y += .1 * delta

func _on_play_button_pressed():
	main_menu.hide()
	stage_select.show()

func _on_settings_button_pressed():
	# Open Settings Menu
	pass

func _on_credits_button_pressed():
	# _play_credits()
	pass

func _on_quit_button_pressed():
	get_tree().quit()

func _on_button_pressed():
	_go_main_menu()
	
func _go_main_menu():
	stage_select.hide()
	main_menu.show()


func _on_level_button_level_button_pressed(button_level):
	get_tree().change_scene_to_file(levels[button_level])
