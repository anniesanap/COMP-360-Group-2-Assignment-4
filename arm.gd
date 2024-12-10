extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var raycast = $Armature/Skeleton3D/BoneAttachment3D/RayCast3D

var rotating: bool = false

func _ready() -> void:
	animation_player.animation_finished.connect(
		func(animation_name: String) -> void:
			if animation_name == "letgo":
				animation_player.play_backwards("letgo")
				animation_player.queue("idle")
	)
	animation_player.animation_changed.connect(
		func(old_animation: String, _new_animation: String) -> void:
			if old_animation == "grab":
				var collider: RigidBody3D = null
				if raycast.is_colliding():
					collider = raycast.get_collider()
				if collider.is_in_group("bowls"):
					collider.spawn_item()
				if collider.coin:
					# Win logic here
					pass
				else:
					# Lose logic here
					pass
	)

func arm_grab():
	animation_player.play("grab")
	rotating = false
	animation_player.queue("pickup")
	animation_player.queue("letgo")
