extends RigidBody3D
var initial_impulse: Vector3 = Vector3(0,7,0)
var object: RigidBody3D = null
@onready var coin_explosion: GPUParticles3D = $"coin explosion"
@onready var wrong_bowl: GPUParticles3D = $"thumbs_down"
var coin: bool = false
@onready var initial_transform: Transform3D = global_transform
@onready var player: CharacterBody3D = $".."/player

func _ready() -> void:
	apply_impulse(initial_impulse)

func spawn_item() -> void:
	if object.get_parent() == null:
		get_parent_node_3d().add_child(object)

func take_item() -> void:
	if object.get_parent() != null:
		object.get_parent().remove_child(object)

func reset() -> void:
	add_collision_exception_with(player)
	var reset_tween: Tween = create_tween()
	reset_tween.tween_property(self, "global_transform", initial_transform, 3.0)
	reset_tween.tween_callback(
		func() -> void:
			object.transform = global_transform
			object.angular_velocity = Vector3.ZERO
			object.linear_velocity = Vector3.ZERO
			angular_velocity = Vector3.ZERO
			linear_velocity = Vector3.ZERO
			remove_collision_exception_with(player)
			take_item()
	)
