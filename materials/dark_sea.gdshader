shader_type spatial;

uniform vec3 base_color : source_color = vec3(1.0f);
uniform sampler2D base_texture : source_color, filter_nearest;
uniform float scroll_speed : hint_range(0.0, 5.0) = 1.0;
uniform float rotation_radians : hint_range(0.0, 2.0 * PI) = 0.0;
uniform vec2 rotation_center = vec2(0.5, 0.5);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float s = sin(rotation_radians);
	float c = cos(rotation_radians);
	mat2 rotation_matrix = mat2(vec2(c,-s),vec2(s,c));
	//vec2 rotated_uv = rotation_matrix * UV;
	vec2 uv = rotation_matrix * (UV - rotation_center) + rotation_center;
	
	vec2 scroll_uv = UV + TIME * scroll_speed;
	vec4 col = texture(base_texture, uv);
	ALBEDO = base_color * col.rgb;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
