extends StaticBody3D

var correct_value : float = 0.0
var equasion : String
@export var obj_num : int

var rng = RandomNumberGenerator.new()

var difficulty = Save.difficulty

func _ready():
	var first_num = rng.randi_range(-10.0, 10.0)
	var second_num = rng.randi_range(-10.0, 10.0)
	var eq_type = rng.randi_range(0, 2)
	
	if eq_type == 0:
		correct_value = first_num + second_num
		equasion = str(first_num) + " + " + str(second_num)
	elif eq_type == 1:
		correct_value = first_num - second_num
		equasion = str(first_num) + " - " + str(second_num)
	elif eq_type == 2:
		correct_value = first_num * second_num
		equasion = str(first_num) + " x " + str(second_num)
	elif eq_type == 3:
		correct_value = first_num / second_num
		equasion = str(first_num) + " / " + str(second_num)
