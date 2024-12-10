shader_type spatial;

uniform float stripe_opacity = 1.0;
uniform vec3 base_colour;
uniform sampler2D normals: hint_normal_roughness_texture;

void vertex() {
	COLOR.rgb = VERTEX.xyz;
}

void fragment() {
	ALBEDO.rgb = base_colour + ((vec3(1.0) - round(abs(sin(TIME - COLOR.x + COLOR.y - COLOR.z)) + 0.48)) * vec3(stripe_opacity));
}