extends MeshInstance3D

func _ready():
	# Loads the shader
	var checker_shader = load("res://path/to/checker_board.gdshader")
	if checker_shader:
		# Creates a ShaderMaterial and assigns the shader
		var checker_material = ShaderMaterial.new()
		checker_material.shader = checker_shader

		# Sets the shader parameters (if needed)
		checker_material.set_parameter("color1", Color(1, 1, 1))  # White
		checker_material.set_parameter("color2", Color(0, 0, 0))  # Black
		checker_material.set_parameter("grid_size", 10.0)  # Adjust grid size

		# Apply the material to the MeshInstance3D
		self.material_override = checker_material
	else:
		push_error("Checkerboard shader not found!")
