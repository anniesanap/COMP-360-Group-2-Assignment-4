shader_type spatial;

uniform float lives = 2;
uniform float max_lives = 2;
uniform vec2 y_bounds = vec2(-0.8, 0.8);

void vertex() {
	COLOR.r = mix(0.0, 1.0, 0.33 - (((y_bounds.y - y_bounds.x) * (lives / max_lives)) - ((y_bounds.y - y_bounds.x) / 2.0)));
	COLOR.g = mix(0.0, 1.0, 0.33 + (((y_bounds.y - y_bounds.x) * (lives / max_lives)) - ((y_bounds.y - y_bounds.x) / 2.0)));
	COLOR.b = 0.0;
	VERTEX.y += sin(TIME - (VERTEX.z * 5.0)) * 0.015;
	UV = VERTEX.xz;
}

void fragment() {
	ALBEDO = COLOR.rgb;
	EMISSION = COLOR.rgb * 1.5;
	ALPHA = sqrt(pow(UV.y, 2.0) + pow(UV.x, 2.0)) < ((y_bounds.y - y_bounds.x) / 2.0) - abs(((y_bounds.y - y_bounds.x) * (lives / max_lives)) - ((y_bounds.y - y_bounds.x) / 2.0)) ? 1.0 : 0.0;
}