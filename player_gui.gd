extends CanvasLayer

@onready var math_menu = $MathMenu
@onready var input = $MathMenu/EntryBox/LineEdit
@onready var error_message_label = $MathMenu/ErrorMessage

var math_menu_enabled = false


func _toggle_math_menu():
	if math_menu_enabled == false:
		math_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		math_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_button_pressed():
	_error_control_text()
	input.text = ''


func _error_control_text():
	if input.text.is_valid_float() == true:
		print(input.text)
	else:
		print("Incorrect input type (input must be a number)")
		error_message_label.show()
		input.editable = false
		await get_tree().create_timer(1).timeout
		error_message_label.hide()
		input.editable = true
