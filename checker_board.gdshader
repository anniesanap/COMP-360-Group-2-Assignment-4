shader_type spatial;

// Uniforms for the checkered pattern
uniform vec3 color1 = vec3(1.0, 1.0, 1.0); // White, hint_color
uniform vec3 color2 = vec3(0.0, 0.0, 0.0); // Black, hint_color
uniform float grid_size = 10.0; // Size of the squares, hint_range(1.0, 100.0)

void fragment() {
    // Scale UV coordinates to control grid size
    vec2 uv = UV * grid_size;

    // Determine which square the fragment belongs to
    float checker = mod(floor(uv.x) + floor(uv.y), 2.0);

    // Assign the color based on the checker value
    vec3 final_color = mix(color1, color2, checker);
    ALBEDO = final_color;
}


