shader_type spatial;

uniform float stripe_size;
uniform vec3 base_colour;
uniform sampler2D normals: hint_normal_roughness_texture;

void vertex() {
	COLOR.rgb = VERTEX.xyz;
}

void fragment() {
	ALBEDO.rgb = mix(vec3(1.0), base_colour, round(abs(sin(TIME - COLOR.x - COLOR.z)) + stripe_size));
}