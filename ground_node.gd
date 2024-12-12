extends Node3D
func _ready():
	print("running")
	var land = MeshInstance3D.new()
	var noise = _heightmap(256, 256)
	var st = _quadgrid(20, 20, noise)
	
	var material = StandardMaterial3D.new()
	material.albedo_texture = load("res://Ground078_4K-JPG_Color.jpg")  
	material.normal_map = load("res://Ground078_4K-JPG_NormalDX.jpg") 
	material.roughness_texture = load("res://Ground078_4K-JPG_Roughness.jpg")  
	#Created using Ground 078 from ambientCG.com 
	#licensed under the Creative Commons CC0 1.0 Universal License.
	#ambientCG.com/a/Ground078
	material.uv1_scale = Vector3(20, 20, 1)  # Adjust tiling
	
	st.generate_normals() # normals point perpendicular up from each face
	var mesh = st.commit() # arranges mesh data structures into arrays for us
	land.mesh = mesh
	land.material_override = material
	add_child(land)
	
	pass

func _quad(st : SurfaceTool, pt : Vector3, count : Array[int], uvpt: Vector2, uvlen: Vector2, noise):
	var offset = Vector3(-10, -0.25, -10)
	st.set_uv( Vector2(uvpt[0], uvpt[1]) )
	st.add_vertex( pt + offset + Vector3(0, (_getHeight(uvpt[0]*(noise.get_height()), uvpt[1]*(noise.get_width()),noise)), 0) ) # vertex 0
	count[0] += 1
	st.set_uv( Vector2(uvpt[0] + uvlen[0], uvpt[1]) )
	st.add_vertex( pt + offset + Vector3(1, (_getHeight((uvpt[0]+uvlen[0])*(noise.get_height()), uvpt[1]*(noise.get_width()),noise)), 0) ) # vertex 1
	count[0] += 1
	st.set_uv( Vector2(uvpt[0] + uvlen[0], uvpt[1] + uvlen[1]) )
	st.add_vertex( pt + offset + Vector3(1, (_getHeight((uvpt[0]+uvlen[0])*(noise.get_height()), (uvpt[1]+uvlen[1])*(noise.get_width()),noise)), 1) ) # vertex 2
	count[0] += 1
	st.set_uv( Vector2(uvpt[0], uvpt[1] + uvlen[1]) )
	st.add_vertex( pt + offset + Vector3(0, (_getHeight(uvpt[0]*(noise.get_height()), (uvpt[1]+uvlen[1])*(noise.get_width()),noise)), 1) ) # vertex 3
	count[0] += 1
	
	st.add_index(count[0] - 4) # make the first triangle
	st.add_index(count[0] - 3)
	st.add_index(count[0] - 2)
	
	st.add_index(count[0] - 4) # make the second triangle
	st.add_index(count[0] - 2)
	st.add_index(count[0] - 1)
	
	pass

func _heightmap(x: int, y: int) -> Image:
# return image of noise with dimensions (x, y)
	var noise = FastNoiseLite.new()
	noise.noise_type = 2
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.fractal_octaves = 5  # Higher for more detail
	noise.fractal_gain = 0.9   # Controls the amplitude of each octave
	noise.frequency = 0.01  # Lower frequency for larger, smoother hills
	noise.domain_warp_enabled = true
	noise.domain_warp_frequency = 0.05
	noise.domain_warp_amplitude = 30
	
	return noise.get_image(x, y)
	
func _quadgrid(x: int, z: int, noise: Image) -> SurfaceTool:
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES) # mode controls kind of geometry
	var count : Array[int] = [0]
	
	for u in range(x): # corner of grid is at x, z
		for v in range(z):
			_quad(st, Vector3(u, 0, v), count, Vector2(float(u)/x, float(v)/z), Vector2(1.0/x, 1.0/z), noise)
	return st

func _getHeight(x, z, noise:Image) -> float:
	var lightness = noise.get_pixel(floor(x),floor(z)).r
	return lightness
