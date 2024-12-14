extends Node3D

@onready var lives_counter: StaticBody3D = $".."/livesCounter
@onready var animation_player = $AnimationPlayer
@onready var raycast = $Armature/Skeleton3D/BoneAttachment3D/RayCast3D
@onready var joint = $Armature/Skeleton3D/BoneAttachment3D/Generic6DOFJoint3D
@onready var player = $".."/player

var rng = RandomNumberGenerator.new()

signal win

func _ready() -> void:
	animation_player.animation_finished.connect(
		func(animation_name: String) -> void:
			# Disconnect object from joint and throw if its rigidbody
			if animation_name == "letgo":
				var grabbed_object: RigidBody3D = get_node(joint.node_b) if joint.node_b != NodePath("") else null
				if grabbed_object is RigidBody3D:
					joint.node_b = ""
					grabbed_object.apply_impulse(Vector3(-10,0,rng.randi_range(-10,10)))
					if grabbed_object.is_in_group("bowls") and grabbed_object.coin:
						pass
						#lives_counter.set_lives(min(lives_counter.lives + 1.0, lives_counter.max_lives))
					else:
						lives_counter.set_lives(lives_counter.lives - 1.0)
						# Re-activate buttons after throwing if object is not the correct one
						for button: StaticBody3D in get_parent_node_3d().buttons:
							button.toggle_button(true)
					# Turn all buttons red
					for button: StaticBody3D in get_parent_node_3d().buttons:
						create_tween().tween_method(button.set_shader_base_colour, button.material.get_shader_parameter("base_colour"), Vector3(1.0, 0.0, 0.0), 0.2)
				animation_player.play_backwards("letgo")
				animation_player.queue("idle")
	)
	animation_player.animation_changed.connect(
		func(old_animation: String, _new_animation: String) -> void:
			# Attach object to joint if its rigidbody
			if old_animation == "grab":
				var collider: PhysicsBody3D
				if raycast.is_colliding():
					collider = raycast.get_collider()
					if collider is RigidBody3D:
						joint.node_b = collider.get_path()
						if collider.is_in_group("bowls"):
							collider.spawn_item()
			if old_animation == "pickup":
				# Play particle effects depending on if correct coin bowl is picked
				var grabbed_object: RigidBody3D = get_node(joint.node_b) if joint.node_b != NodePath("") else null
				if grabbed_object and grabbed_object.is_in_group("bowls"):
					if grabbed_object.coin:
						grabbed_object.coin_explosion.emitting = true
						get_tree().create_timer(3.0).timeout.connect(win.emit)
					elif not grabbed_object.coin:
						grabbed_object.wrong_bowl.emitting = true
						# Throw orange at player
						grabbed_object.object.apply_impulse((player.global_position - grabbed_object.object.global_position + Vector3.UP).normalized() * 7)
	)

# Animation sequence
func arm_grab():
	animation_player.play("grab")
	animation_player.queue("pickup")
	animation_player.queue("letgo")
