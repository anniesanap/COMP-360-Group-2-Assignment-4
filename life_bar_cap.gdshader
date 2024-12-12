shader_type spatial;

void vertex() {
	COLOR.r = mix(0.0, 1.0, 0.33 - VERTEX.y);
	COLOR.g = mix(0.0, 1.0, 0.33 + VERTEX.y);
	COLOR.b = 0.0;
	VERTEX.y -= abs(sin(TIME - (VERTEX.z * 5.0))) * 0.01;
	UV = VERTEX.xz;
}

void fragment() {
	ALBEDO = EMISSION = COLOR.rgb * 1.5;
	ALPHA = sqrt(pow(UV.y, 2.0) + pow(UV.x, 2.0)) < 0.1 ? 1.0 : 0.0;
}