extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 4.5 
@export var mouse_sens = 0.4

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var interaction_cast = $Head/InteractionCast
@onready var gui = $PlayerGui

var can_move = true

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _input(event):
	# Detects when the player moves the mouse, rotates camera accordingly
	if can_move:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
			head.rotation.x = clamp(head.rotation.x, -1, 1)


func _ready():
	# Sets the mouse mode to captured
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta):
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
		
		if body.is_in_group("interactable"):
			body._interact()
			
		if body.is_in_group("math_object"):
			var obj_correct_val = body.correct_value
			gui._toggle_math_menu()
