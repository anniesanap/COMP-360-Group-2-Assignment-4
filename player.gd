extends CharacterBody3D

@onready var camera = $playerCamera
@onready var raycast = $playerCamera/playerRaycast

const SPEED = 4.0
const JUMP_VELOCITY = 5.0

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	# Rotate camera
	if event is InputEventMouseMotion:
		camera.rotation.x = clamp(camera.rotation.x - event.screen_relative.y * 0.002, -PI / 2, PI / 2)
		camera.rotation.y -= event.screen_relative.x * 0.002
	# Allow mouse to leave window
	elif event.is_action_pressed("escape") and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.mouse_set_mode(2 * 1 - (int(DisplayServer.mouse_get_mode())))
	# Toggle fullscreen
	elif event.is_action_pressed("fullscreen"):
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
		DisplayServer.window_set_mode(3 - int(DisplayServer.window_get_mode()))
	# Handle jump
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif event.is_action_pressed("interact"):
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider != null:
				if collider.is_in_group("buttons"):
					collider.press()
				elif collider.is_in_group("bowls") and not collider.object.is_inside_tree():
					collider.reset()
			
	# Handle movement keys
	var movement = Input.get_vector("move_left", "move_right", "move_forward", "move_back").rotated(-camera.rotation.y)
	velocity.x = -movement.y * SPEED
	velocity.z = movement.x * SPEED
