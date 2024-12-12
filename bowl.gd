extends RigidBody3D
var initialImpulse: Vector3 = Vector3(0,5,0)
var object: RigidBody3D = null
@onready var coin_explosion: GPUParticles3D = $"coin explosion"
var coin: bool = false
var random = RandomNumberGenerator.new()
@onready var initialPosition: Vector3 = global_transform.origin

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(initialImpulse)

func _get_position() -> Vector3:
	return Vector3(self.x,self.y,self.z)

func spawn_item() -> void:
	if object.get_parent() == null:
		get_parent_node_3d().add_child(object)
	if coin:
		coin_explosion.emitting = true

func _throw() -> void:
	apply_impulse(Vector3(-10,0,random.randi_range(-10,10)))

func _reset_position() -> void:
	self.global_transform.origin = initialPosition
