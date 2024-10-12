shader_type canvas_item;

uniform float y_threshold: hint_range(0.0, 1.0, 0.1) = 0.1;

void fragment() {
	if (COLOR.a != 0.0) {
		if (UV.y >= y_threshold) {
			COLOR.rgb = vec3(1.0);
		}
	}
}