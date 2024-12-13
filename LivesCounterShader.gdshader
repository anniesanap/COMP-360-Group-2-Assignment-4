shader_type spatial;

// Uniforms for customization
uniform vec3 low_lives_color = vec3(1.0, 0.0, 0.0); // Red (danger)
uniform vec3 full_lives_color = vec3(0.0, 1.0, 0.0); // Green (safe)
uniform float gradient_scale = 5.0; // Controls gradient transition sharpness

void fragment() {
    // Use the UV coordinates to create a vertical gradient
    float gradient_position = UV.y * gradient_scale;

    // Interpolate between the two colors based on the gradient position
    vec3 final_color = mix(low_lives_color, full_lives_color, gradient_position);

    // Assign the result to the ALBEDO color
    ALBEDO = final_color;
}

