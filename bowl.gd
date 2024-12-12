extends RigidBody3D
var initialImpulse: Vector3 = Vector3(0,5,0)
var object: RigidBody3D = null
@onready var coin_explosion: GPUParticles3D = $"coin explosion"
var coin: bool = false
@onready var initialPosition: Vector3 = global_position

func _ready() -> void:
	apply_impulse(initialImpulse)

func spawn_item() -> void:
	if object.get_parent() == null:
		get_parent_node_3d().add_child(object)
	if coin:
		coin_explosion.emitting = true

func reset_position() -> void:
	global_position = initialPosition
