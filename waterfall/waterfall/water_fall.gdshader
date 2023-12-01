shader_type spatial;

uniform sampler2D noise_tex :repeat_enable;
uniform sampler2D displ_tex :repeat_enable;

uniform float speed: hint_range(0.0, 1.0);
uniform vec4 color: source_color;
uniform float color_mix: hint_range(0.0, 1.0);
uniform float distort_mix: hint_range(0.0, 1.0);

void fragment()
{
    vec4 displacement = texture(displ_tex, UV);

    vec2 distortedUV = UV + displacement.xy * distort_mix;

    vec4 noise = texture(noise_tex, vec2(distortedUV.x, distortedUV.y / 3.0 - TIME * speed));

    noise = round(noise * 4.0) / 4.0;

    ALBEDO = mix(noise, color, color_mix).rgb;
}
