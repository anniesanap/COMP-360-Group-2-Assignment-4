shader_type spatial;

uniform sampler2D thumb_texture;
uniform float scale_factor : hint_range(0.1, 5.0);  // Allows you to scale the texture

void fragment() {
    vec2 uv_coords = UV;

    // Check if the fragment is on the top or bottom face of the cylinder
    if (uv_coords.y > 0.8 || uv_coords.y < 0.8) {
        // Apply the scaling to the UV coordinates
        uv_coords *= scale_factor;  // Scale the texture coordinates

        // Wrap the texture horizontally to avoid stretching if the UVs go beyond the [0.0, 1.0] range
        uv_coords.x = mod(uv_coords.x, 1.0);

        // Sample the texture at the adjusted coordinates
        vec4 thumb_color = texture(thumb_texture, uv_coords);

        // Set the color of the fragment to the texture's color
        ALBEDO = thumb_color.rgb;
    } else {
        // For the side faces, set the color to white (or any other color for the sides)
        ALBEDO = vec3(1.0, 1.0, 1.0);
    }
}
