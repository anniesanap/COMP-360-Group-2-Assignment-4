extends StaticBody3D

@onready var life_meter: MeshInstance3D = $lifeMeter
@onready var bar_shader: ShaderMaterial = $lifeMeter.mesh.material
@onready var cap_shader: ShaderMaterial = $lifeMeter/lifeMeterCap.mesh.material
var lives: float = 2.0
var max_lives: float = 2.0

func _ready() -> void:
	pass
