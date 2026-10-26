shader_type spatial;
render_mode cull_disabled, world_vertex_coords;
uniform vec3 base_color : source_color = vec3(1.0);
uniform sampler2D base_texture : source_color, filter_nearest;
uniform float wave_speed : hint_range(0.0, 5.0, 0.5);
uniform float wave_height: hint_range(0.0, 0.5, 0.1);
uniform float wave_scale: hint_range(0.0, 10.0, 1.0);
uniform float wave_darkening : hint_range(0.0, 1.0, 0.5);
varying float displacement;


void vertex() {
	// Called for every vertex the material is visible on.
	vec3 pos = VERTEX;
	displacement = sin(pos.x + pos.z * wave_scale + TIME * 2.0 * PI * wave_speed) * wave_height;
	pos.y += displacement;
	VERTEX = pos;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = texture(base_texture, UV);
	float tint = (displacement/wave_height + 1.0) * 0.5;
	tint = mix(1.0 - wave_darkening, 1.0, tint);
	ALBEDO = base_color * col.rgb*tint;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
