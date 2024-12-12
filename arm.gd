extends Node3D

@onready var lives_counter: StaticBody3D = $".."/livesCounter
@onready var animation_player = $AnimationPlayer
@onready var raycast = $Armature/Skeleton3D/BoneAttachment3D/RayCast3D
@onready var joint = $Armature/Skeleton3D/BoneAttachment3D/Generic6DOFJoint3D

var rng = RandomNumberGenerator.new()

var rotating: bool = false

func _ready() -> void:
	animation_player.animation_finished.connect(
		func(animation_name: String) -> void:
			if animation_name == "letgo":
				var grabbed_object: RigidBody3D = get_node(joint.node_b) if joint.node_b != NodePath("") else null
				if grabbed_object is RigidBody3D:
					joint.node_b = ""
					grabbed_object.apply_impulse(Vector3(-10,0,rng.randi_range(-10,10)))
					if grabbed_object.is_in_group("bowls") and grabbed_object.coin:
						lives_counter.set_lives(lives_counter.max_lives)
					else:
						lives_counter.set_lives(lives_counter.lives - 1.0)
				animation_player.play_backwards("letgo")
				animation_player.queue("idle")
	)
	animation_player.animation_changed.connect(
		func(old_animation: String, _new_animation: String) -> void:
			if old_animation == "grab":
				var collider: PhysicsBody3D
				if raycast.is_colliding():
					collider = raycast.get_collider()
					if collider is RigidBody3D:
						joint.node_b = collider.get_path()
						if collider.is_in_group("bowls"):
							collider.spawn_item()
	)

func arm_grab():
	animation_player.play("grab")
	rotating = false
	animation_player.queue("pickup")
	animation_player.queue("letgo")
