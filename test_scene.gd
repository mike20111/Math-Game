extends Node3D

# When the player enters the correct value
func _on_player_correct_value_entered(obj_num):
	if obj_num == 0:
		$InteractBody.position = Vector3(3,3,3)
