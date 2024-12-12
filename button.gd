extends StaticBody3D

@export var arm_rotation: float = PI / 2

@onready var arm: Node3D = $".."/arm
@onready var material: ShaderMaterial = $buttonMesh.mesh.material
@onready var buttons: Array[StaticBody3D] = [$".."/button1, $".."/button2, $".."/button3]

var set_shader_base_colour: Callable = func(colour: Vector3): material.set_shader_parameter("base_colour", colour)

func _ready() -> void:
	arm.animation_player.animation_changed.connect(
		func(_old_animation: String, new_animation: String) -> void:
			if new_animation == "idle":
				if is_equal_approx(arm.rotation.y, arm_rotation):
					create_tween().tween_method(set_shader_base_colour, Vector3(0.0, 1.0, 0.0), Vector3(1.0, 0.0, 0.0), 0.2)
				create_tween().tween_method(func(opacity: float): material.set_shader_parameter("stripe_opacity", opacity), 0.0, 1.0, 0.1)
	)

func press():
	if not arm.rotating and arm.animation_player.current_animation == "idle":
		arm.rotating = true
		for button in buttons:
			create_tween().tween_method(button.set_shader_stripe_opacity, 1.0, 0.0, 0.1)
		create_tween().tween_method(set_shader_base_colour, Vector3(1.0, 0.0, 0.0), Vector3(0.0, 1.0, 0.0), 0.2)
		var rotate_tween = create_tween()
		rotate_tween.tween_property(arm, "rotation:y", arm_rotation, abs(arm.rotation.y - arm_rotation) / (PI / 4)).set_delay(0.5).set_trans(Tween.TRANS_SPRING)
		rotate_tween.finished.connect(arm.arm_grab)
