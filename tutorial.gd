extends Node3D

@onready var cutscene_camera = $CutsceneCameras
@onready var cutscene_player = $CutsceneAnimPlayer
@onready var player = $Player

var total_time : int


# When the player enters the correct value
func _on_player_correct_value_entered(obj_num):
	if obj_num == 0:
		player.can_move = false
		$CutsceneAnimPlayer.play("cutscene_1")
		$CusceneCameras/Cam1.make_current()
		await cutscene_player.animation_finished
		$Player/Head/Camera3D.make_current()
		player.can_move = true
		$Labels/Label3D4.visible = false
		
	elif obj_num == 1:
		player.can_move = false
		$CutsceneAnimPlayer.play("cutscene_2")
		$CusceneCameras/Cam2.make_current()
		await cutscene_player.animation_finished
		$Player/Head/Camera3D.make_current()
		player.can_move = true

func _on_player_game_win():
	var previous_time_taken = Save.test_scene_pb
	$Player.gui.previous_time_label.text =  "your previous best is " + str(previous_time_taken) + " seconds"
	total_time = player.time_taken
	if total_time < Save.test_scene_pb:
		Save.test_scene_pb = total_time
	Save.save()
