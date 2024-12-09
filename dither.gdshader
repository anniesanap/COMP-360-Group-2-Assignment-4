shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture;
uniform sampler2D dither_texture;

uniform ivec2 dither_texture_size;
uniform float r;

uniform vec3 num_colours;

void fragment() {
	vec3 orig_pixel = texture(screen_texture, SCREEN_UV).rgb;
	
	COLOR.rgb = trunc(
		(orig_pixel + (r * texelFetch(
			dither_texture,
			ivec2(SCREEN_UV / SCREEN_PIXEL_SIZE) % dither_texture_size,
			0
		)).rgb) * num_colours
	) / num_colours;
}