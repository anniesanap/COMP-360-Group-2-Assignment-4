shader_type spatial;

uniform float lives = 2;
uniform float max_lives = 2;
uniform vec2 y_bounds = vec2(-0.8, 0.8);

void vertex() {
	COLOR.r = mix(0.0, 1.0, 0.33 - VERTEX.y);
	COLOR.g = mix(0.0, 1.0, 0.33 + VERTEX.y);
	COLOR.b = 0.0;
	UV.x = VERTEX.z;
	UV.y = VERTEX.y;
}

void fragment() {
	ALBEDO = COLOR.rgb;
	EMISSION = COLOR.rgb * 1.5;
	ALPHA = ((y_bounds.y - y_bounds.x) * lives / max_lives) + y_bounds.x + (sin(TIME - (UV.x * 5.0)) * 0.015) < UV.y ? 0.0 : 1.0;
}