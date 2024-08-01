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
		$CutsceneCameras/Cam1.make_current()
		await get_tree().create_timer(1).timeout
		$Door/MeshInstance3D.position += Vector3(0, 0, 1)
		$Door/MeshInstance3D2.position += Vector3(0, 0, -1)
		await cutscene_player.animation_finished
		$Player/Head/Camera3D.make_current()
		player.can_move = true

func _on_player_game_win():
	total_time = player.time_taken
	if total_time < Save.test_scene_pb:
		Save.test_scene_pb = total_time
	Save.save()
