shader_type spatial;

uniform float height = 0.9;

void vertex() {
	COLOR.g = mix(0.0, 1.0, 0.33 + height);
	COLOR.r = mix(0.0, 1.0, 0.33 - height);
	COLOR.b = 0.0;
	VERTEX.y -= abs(sin(TIME - (VERTEX.z * 5.0))) * 0.015;
	UV = VERTEX.xz;
}

void fragment() {
	ALBEDO = EMISSION = COLOR.rgb * 1.5;
	ALPHA = sqrt(pow(UV.y, 2.0) + pow(UV.x, 2.0)) < 0.9 - abs(height) ? 1.0 : 0.0;
}