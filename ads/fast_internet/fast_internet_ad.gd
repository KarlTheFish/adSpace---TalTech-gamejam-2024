extends BaseAdvertisement

var shader_material: ShaderMaterial
var y_threshold: float = 0.1

func _ready() -> void:
	close_button.hide()
	shader_material = ShaderMaterial.new()
	shader_material.shader = load("res://ads/fast_internet/fast_internet_ad.gdshader") as Shader
	ad_window.material = shader_material
	super()

func _physics_process(delta: float) -> void:
	if (y_threshold >= 0.95):
		close_button.show()
		return
	if (randf() <= (0.5 * delta)):
		y_threshold += 0.1
		shader_material.set_shader_parameter("y_threshold", y_threshold)
