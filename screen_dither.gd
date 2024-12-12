extends ColorRect

# Specify size of dither texture at runtime
func _ready() -> void:
	material.set_shader_parameter("dither_texture_size", material.get_shader_parameter("dither_texture").get_size())
