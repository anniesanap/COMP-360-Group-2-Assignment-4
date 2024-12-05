extends RigidBody3D
var initialImpulse = Vector3(0,5,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(initialImpulse)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
