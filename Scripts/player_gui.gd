extends CanvasLayer

signal correct_value_entered

@onready var math_menu = $MathMenu
@onready var input = $MathMenu/EntryBox/LineEdit
@onready var error_message_label = $MathMenu/ErrorMessage
@onready var equasion_label = $MathMenu/EquasionLabel
@onready var timer_control = $TimerControl
@onready var timer_label = $TimerControl/TimerLabel
@onready var win_menu = $WinMenu
@onready var win_time_label = $WinMenu/WinTimeLabel
@onready var previous_time_label = $WinMenu/PreviousTimeLabel

var math_menu_enabled : bool = false
var player_num_input : float
var obj_equasion
var obj_correct_val
var time : int

# Toggles UI visibility
func _toggle_math_menu():
	if math_menu.visible == false:
		math_menu.show()
		await get_tree().create_timer(0.1).timeout
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else:
		math_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Sets the variables for the UI on player interact
func _set_var(x, y):
	obj_equasion = x
	obj_correct_val = float(y)
	
	equasion_label.text = obj_equasion

# Checks for correct answer and responds accordingly
func _on_button_pressed():
	# If answer correct
	if _text_valid() == true:
		player_num_input = float(input.text)
		if player_num_input == obj_correct_val:
			print("correct value")
			emit_signal("correct_value_entered")
			_toggle_math_menu()
			input.text = ""
		else:
			# If answer incorrect
			input.text = ""
			print("incorrect value")
			error_message_label.text = "wrong answer"
			error_message_label.show()
			input.editable = false
			await get_tree().create_timer(.5).timeout
			error_message_label.hide()
			input.editable = true
	else:
		# If answer invalid
		input.text = ""
		print("Incorrect input type (input must be a number)")
		error_message_label.text = "Incorrect input type (input must be a number)"
		error_message_label.show()
		input.editable = false
		await get_tree().create_timer(1).timeout
		error_message_label.hide()
		input.editable = true


# Validates Input
func _text_valid() -> bool:
	if input.text.is_valid_float():
		return true
	else:
		return false

# Closes math menu on exit button
func _on_exit_button_pressed():
	_toggle_math_menu()

# Take to main menu if menu button pressed
func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
