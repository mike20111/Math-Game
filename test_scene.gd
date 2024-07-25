extends Node3D

@onready var cutscene_camera = $CutsceneCameras
@onready var cutscene_player = $CutsceneAnimPlayer

# When the player enters the correct value
func _on_player_correct_value_entered(obj_num):
	if obj_num == 0:
		$CutsceneAnimPlayer.play("cutscene_1")
		$CutsceneCameras/Cam1.make_current()
		await get_tree().create_timer(1).timeout
		$Door/MeshInstance3D.position += Vector3(0, 0, 1)
		$Door/MeshInstance3D2.position += Vector3(0, 0, -1)
		await get_tree().create_timer(1).timeout
		$Player/Head/Camera3D.make_current()
