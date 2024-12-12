extends GPUParticles3D

# Variables for particle settings
var particle_amount = 6
var velocity_min = 0.0
var velocity_max = 0
var explosion_radius = 11.0
var spread = 0
var spread_angle_min = 0
var spread_angle_max = 0

func _ready():
	# Create and assign a ParticleProcessMaterial
	var particles_material = ParticleProcessMaterial.new()
	process_material = particles_material
	
	# Configure emission shape
	particles_material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
	particles_material.emission_sphere_radius = 0.4
	
	
	
	# Configure particle properties
	#particles_material.lifetime = 2.0
	#particles_material.lifetime_randomness = 0.5
	particles_material.initial_velocity_min = velocity_min
	particles_material.initial_velocity_max = velocity_max
	particles_material.angle_min = spread_angle_min
	particles_material.angle_max = spread_angle_max
	#particles_material.spread = spread
	particles_material.gravity = Vector3(0, -10, 0)
	
	# Set particle system position and other properties
	#transform.origin = hardcoded_position
	amount = particle_amount
	one_shot = true  # Emit particles only once
