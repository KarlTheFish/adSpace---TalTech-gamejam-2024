extends Area2D

@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D
@export var particles: GPUParticles2D

const TEXTURES: Array[CompressedTexture2D] = [
	preload("res://tasks/toilet/sprites/kaka1.png") as CompressedTexture2D,
	preload("res://tasks/toilet/sprites/kaka2.png") as CompressedTexture2D,
	preload("res://tasks/toilet/sprites/kaka3.png") as CompressedTexture2D,
	preload("res://tasks/toilet/sprites/kaka4.png") as CompressedTexture2D,
]

const MAX_HEALTH: int = 100
var health: int = MAX_HEALTH

func _ready() -> void:
	var texture: CompressedTexture2D = TEXTURES.pick_random()
	sprite.texture = texture
	collision_shape.shape.size = texture.get_size()

func _physics_process(delta: float) -> void:
	particles.emitting = false
	if (has_overlapping_areas()):
		particles.emitting = true
		health -= 1
		modulate.a = max(0.2, float(health) / float(MAX_HEALTH))
		if (health == 0):
			queue_free()
