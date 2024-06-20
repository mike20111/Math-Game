extends CanvasLayer

@onready var math_menu = $MathMenu

var math_menu_enabled = false

func _toggle_math_menu():
	if math_menu_enabled == false:
		math_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		math_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
