extends StaticBody3D

@onready var life_meter: MeshInstance3D = $lifeMeter
@onready var bar_shader: ShaderMaterial = $lifeMeter.mesh.material
@onready var cap_shader: ShaderMaterial = $lifeMeter/lifeMeterCap.mesh.material
@onready var cap: MeshInstance3D = $lifeMeter/lifeMeterCap

signal game_lost

var lives: float = 2.0
var max_lives: float = 2.0

func set_lives(new_lives: float, new_max_lives: float = max_lives) -> void:
	create_tween().tween_method(func(new_value) -> void: bar_shader.set_shader_parameter("lives", new_value), lives, new_lives, 3.0).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_method(func(new_value) -> void: cap_shader.set_shader_parameter("lives", new_value), lives, new_lives, 3.0).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_method(func(new_value) -> void: bar_shader.set_shader_parameter("max_lives", new_value), max_lives, new_max_lives, 3.0).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_method(func(new_value) -> void: cap_shader.set_shader_parameter("max_lives", new_value), max_lives, new_max_lives, 3.0).set_trans(Tween.TRANS_CUBIC)
	create_tween().tween_property(cap, "position:y", life_meter.position.y + ((new_lives / new_max_lives) * life_meter.mesh.height) - (life_meter.mesh.height / 2), 3.0).set_trans(Tween.TRANS_CUBIC)
	lives = new_lives
	max_lives = new_max_lives
	if is_zero_approx(lives):
		get_tree().create_timer(8.0).timeout.connect(game_lost.emit)
