extends Button

signal level_button_pressed

@export var button_level : int

func _on_pressed():
	emit_signal("level_button_pressed", button_level)
