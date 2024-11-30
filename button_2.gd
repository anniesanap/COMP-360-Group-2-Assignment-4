extends StaticBody3D

@onready var arm: Node3D = $".."/arm
@onready var material: StandardMaterial3D = $buttonMesh.mesh.material

func press():
	create_tween().tween_property(material, "albedo_color", Color.GREEN, 0.2)
	var rotate_tween = create_tween()
	rotate_tween.tween_property(arm, "rotation:y", PI / 2, 1).set_delay(0.5).set_trans(Tween.TRANS_SPRING)
	rotate_tween.tween_property(material, "albedo_color", Color.RED, 0.2)
	rotate_tween.finished.connect(arm.arm_grab)
