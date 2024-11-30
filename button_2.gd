extends StaticBody3D

@onready var button_1_material: StandardMaterial3D = $".."/button1/buttonMesh.mesh.material
@onready var button_3_material: StandardMaterial3D = $".."/button3/buttonMesh.mesh.material
@onready var arm: Node3D = $".."/arm
@onready var material: StandardMaterial3D = $buttonMesh.mesh.material
@onready var arm_animation: AnimationPlayer = $".."/arm/AnimationPlayer

func press():
	create_tween().tween_property(button_1_material, "albedo_color", Color.RED, 0.2)
	create_tween().tween_property(button_3_material, "albedo_color", Color.RED, 0.2)
	create_tween().tween_property(material, "albedo_color", Color.GREEN, 0.2)
	var rotate_tween = create_tween()
	rotate_tween.tween_property(arm, "rotation:y", PI / 2, 1).set_delay(0.5).set_trans(Tween.TRANS_SPRING)
	rotate_tween.finished.connect(arm_animation.play.bind("grab"))
