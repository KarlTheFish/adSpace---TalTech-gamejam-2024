class_name Asteroid extends Area2D

signal destroyed

@export var sprite: Sprite2D
@export var particles: GPUParticles2D
@export var destruction_timer: Timer

var rotation_increment: int = randi_range(-4, 4)
var speed: int = randi_range(25, 100)
var direction: int = 0

func _ready() -> void:
	area_entered.connect(_area_entered)
	destruction_timer.timeout.connect(_timer_done)
	var i: float = randf_range(0.5, 2.0)
	scale = Vector2(i, i)
	rotation_degrees = randi_range(0, 360)
	direction = 1 if (position.x <= 160) else -1

func _physics_process(delta: float) -> void:
	rotation_degrees += rotation_increment
	position.x += (direction * speed * delta)
	if (position.x < -50 or position.x > 370):
		queue_free()

func _area_entered() -> void:
	destroyed.emit()
	sprite.hide()
	particles.emitting = true
	destruction_timer.start()

func _timer_done() -> void:
	queue_free()
