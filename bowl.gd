extends RigidBody3D
var initialImpulse: Vector3 = Vector3(0,5,0)
var object: RigidBody3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(initialImpulse)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
