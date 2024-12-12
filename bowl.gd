extends RigidBody3D
var initial_impulse: Vector3 = Vector3(0,7,0)
var object: RigidBody3D = null
@onready var coin_explosion: GPUParticles3D = $"coin explosion"
var coin: bool = false
@onready var initial_transform: Transform3D = global_transform

func _ready() -> void:
	apply_impulse(initial_impulse)

func spawn_item() -> void:
	if object.get_parent() == null:
		get_parent_node_3d().add_child(object)

func take_item() -> void:
	if object.get_parent() != null:
		object.get_parent().remove_child(object)

func reset() -> void:
	take_item()
	freeze = true
	var reset_tween: Tween = create_tween()
	reset_tween.tween_property(self, "global_transform", initial_transform, 3.0)
	reset_tween.tween_callback(func() -> void: angular_velocity = Vector3.ZERO; linear_velocity = Vector3.ZERO; freeze = false)
