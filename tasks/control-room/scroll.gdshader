shader_type canvas_item;

uniform float scroll_speed : hint_range(-5.0, 5.0, 0.01) = 0.02;
uniform vec2 DIRECTION = vec2(1, 0);

void fragment() {
	vec2 offset_uv = UV - (TIME * scroll_speed * DIRECTION);
	vec2 scaled_uv = fract(offset_uv);
	COLOR = texture(TEXTURE, scaled_uv);
}