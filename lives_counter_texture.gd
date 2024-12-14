extends MeshInstance3D

func _ready():
	# Load the shader
	var lives_shader = load("res://path/to/LivesCounterShader.gdshader")
	if lives_shader:
		# Create a ShaderMaterial and assign the shader
		var lives_material = ShaderMaterial.new()
		lives_material.shader = lives_shader

		# Set shader parameters
		lives_material.set_parameter("low_lives_color", Color(1.0, 0.0, 0.0))  # Red
		lives_material.set_parameter("full_lives_color", Color(0.0, 1.0, 0.0))  # Green
		lives_material.set_parameter("gradient_scale", 3.0)  # Adjust sharpness

		# Apply the material override to the livescounter
		self.material_override = lives_material
	else:
		push_error("Livescounter shader not found!")
