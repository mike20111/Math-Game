extends CharacterBody3D

signal correct_value_entered

# Export variables to edit in viewport
@export var speed : float = 5.0
@export var jump_velocity : float = 4.5 
@export var mouse_sens : float = 0.4

# Creates variables for tree objects for quick access
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var interaction_cast = $Head/InteractionCast
@onready var gui = $PlayerGui

# Variables
var can_move : bool = true
var player_num_input : float
var obj_num : int

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# On input
func _input(event):
	# Detects when the player moves the mouse, rotates camera accordingly
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, -1, 1)

# On start
func _ready():
	# Sets the mouse mode to captured
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called at a fixed rate
func _physics_process(delta):
	
	if gui.math_menu.visibility_changed:
		if gui.math_menu.visible == true:
			can_move = false
		else:
			can_move = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle interact
	if Input.is_action_just_pressed("interact"):
		_interact()
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		
	move_and_slide()


# Detect object from raycast
func _interact():
	if interaction_cast.is_colliding():
		var body = interaction_cast.get_collider()
		
		# Triggers interaction if valid object
		if body.is_in_group("interactable"):
			if body.has_method("_interact"):
				body._interact()
		
		# Triggers math menu if valid object
		if body.is_in_group("math_object"):
			var obj_correct_val = body.correct_value
			var obj_equasion = body.equasion
			obj_num = body.obj_num
			gui._toggle_math_menu()
			gui._set_var(obj_equasion, obj_correct_val)

# Sends signal to world script
func _on_player_gui_correct_value_entered():
	emit_signal("correct_value_entered", obj_num)
