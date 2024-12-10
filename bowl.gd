extends RigidBody3D
var initialImpulse: Vector3 = Vector3(0,5,0)
var object: RigidBody3D = null
@onready var coin_explosion: GPUParticles3D = $"coin explosion"
var coin: bool = false

@onready var root = $/root/root

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(initialImpulse)

func spawn_item() -> void:
	if object.get_parent() == null:
		root.add_child(object)
	if coin:
		coin_explosion.emitting = true
