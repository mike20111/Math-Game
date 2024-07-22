extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var main_menu = $Main
@onready var stage_select = $StageSelect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		stage_select.hide()
		main_menu.show()

func _on_play_button_pressed():
	main_menu.hide()
	stage_select.show()

func _on_settings_button_pressed():
	# _settings_menu_toggle()
	pass

func _on_credits_button_pressed():
	# _play_credits()
	pass

func _on_quit_button_pressed():
	get_tree().quit()

func _stage_menu_toggle():
	pass


func _on_tutorial_button_pressed():
	get_tree().change_scene_to_file("res://test_scene.tscn")


func _on_level_button_pressed():
	#get buton to pass int, use int to get the number of level in lsit , use list to get stage
