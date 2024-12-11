shader_type spatial;

uniform float lives = 2.0;
uniform int max_lives = 2;
uniform vec2 y_bounds = vec2(-1.0, 1.0);

void vertex() {
	COLOR.r = mix(0.0, 1.0, 0.33 - VERTEX.y);
	COLOR.g = mix(0.0, 1.0, 0.33 + VERTEX.y);
	COLOR.b = 0.0;
	COLOR.a = VERTEX.y;
}

void fragment() {
	ALBEDO = COLOR.rgb;
	EMISSION = COLOR.rgb * 2.0;
	//ALPHA = COLOR.b + y_bounds.x < lives / float(max_lives) ? 0.0 : 1.0;
}