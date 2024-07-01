extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var main_menu = $Main
@onready var stage_select = $StageSelect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
	_stage_menu_toggle()

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
