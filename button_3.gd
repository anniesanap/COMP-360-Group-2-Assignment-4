extends StaticBody3D

@onready var button_1_material: StandardMaterial3D = $".."/button1/buttonMesh.mesh.material
@onready var button_2_material: StandardMaterial3D = $".."/button2/buttonMesh.mesh.material
@onready var arm: Node3D = $".."/arm
@onready var material: StandardMaterial3D = $buttonMesh.mesh.material

func press():
	create_tween().tween_property(button_1_material, "albedo_color", Color.RED, 0.2)
	create_tween().tween_property(button_2_material, "albedo_color", Color.RED, 0.2)
	create_tween().tween_property(material, "albedo_color", Color.GREEN, 0.2)
	create_tween().tween_property(arm, "rotation:y", 3 * PI / 4, 1).set_delay(0.5).set_trans(Tween.TRANS_SPRING)
