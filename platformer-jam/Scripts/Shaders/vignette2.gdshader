shader_type canvas_item;

uniform float inner_radius = 0.1;
uniform float outer_radius = 1;
uniform float vignette_strength = 1.0;
uniform float dither_strength = 0.03;
uniform vec4 vignette_color: source_color;


void fragment() {
	float dist = distance(UV, vec2(0.5));
	
	float vignette = pow(smoothstep(inner_radius, outer_radius, dist), 0.2) * vignette_strength;
	float dither = fract(sin(dot(UV, vec2(12.9898, 78.233))) * 43758.5453123 * TIME) * dither_strength;
	
	COLOR = vec4(vignette_color.rgb, vignette + dither);
}