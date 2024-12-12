extends RigidBody3D
var initial_impulse: Vector3 = Vector3(0,7,0)
var object: RigidBody3D = null
@onready var coin_explosion: GPUParticles3D = $"coin explosion"
@onready var wrong_bowl: GPUParticles3D = $"thumbs_down"
var coin: bool = false
@onready var initial_transform: Transform3D = global_transform

# Add bowl's item to scene tree
func spawn_item() -> void:
	if object.get_parent() == null:
		get_parent_node_3d().add_child(object)

# Remove bowl's item from scene tree (for when after bowl lands)
func take_item() -> void:
	if object.get_parent() != null:
		object.get_parent().remove_child(object)
		object.transform = global_transform
		object.angular_velocity = Vector3.ZERO
		object.linear_velocity = Vector3.ZERO

# Tween bowl position back to original position so that it can be shuffled
func reset() -> void:
	var reset_tween: Tween = create_tween()
	reset_tween.tween_property(self, "global_transform", initial_transform, 2.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	reset_tween.tween_callback(
		func() -> void:
			angular_velocity = Vector3.ZERO
			linear_velocity = Vector3.ZERO
			take_item()
	)
