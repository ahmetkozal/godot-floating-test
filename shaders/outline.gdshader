shader_type spatial;
render_mode cull_front, unshaded;
uniform float outline_width : hint_range(0.0f, 0.05f) = 0.01f;
uniform vec4 outline_color : source_color = vec4(vec3(0.0f), 1.0f);
void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX += NORMAL * outline_width;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = outline_color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
