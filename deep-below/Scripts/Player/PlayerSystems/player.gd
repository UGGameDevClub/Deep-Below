extends CharacterBody3D

@export var camera_sensitivity = 700##Counter-intuitively, increasing the value makes the camera more sensitive. No I do not understand why.
@export var is_underwater = false##When true, changes movement settings to be more sluggish to better approximate an underwater environment/feel
@export var default_speed = 5.0##Walk speed when in the submarine
@export var jump_strength = 4.5
@export_group("Underwater Settings")
@export var underwater_speed = 2.5##Walk speed when outside the submarine
var speed : float

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if !is_underwater:
		speed = default_speed
	elif is_underwater:
		speed = underwater_speed
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_strength

	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / camera_sensitivity
		$CamPositioner.rotation.x -= event.relative.y / camera_sensitivity
		$CamPositioner.rotation.x = clamp($CamPositioner.rotation.x, deg_to_rad(-65), deg_to_rad(90))
