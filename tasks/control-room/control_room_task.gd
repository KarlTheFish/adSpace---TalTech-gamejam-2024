extends TaskArea

@export var gun_sprite: Sprite2D
@export var spawn_timer: Timer
@export var counter: Label
@export var audio: AudioStreamPlayer

const ASTEROIDS: Array[PackedScene] = [
	preload("res://tasks/control-room/asteroid/asteroid_1.tscn"),
	preload("res://tasks/control-room/asteroid/asteroid_2.tscn"),
	preload("res://tasks/control-room/asteroid/asteroid_3.tscn"),
]
const BULLET: PackedScene = preload("res://tasks/control-room/bullet.tscn")
const GUN_POS: Vector2 = Vector2(160, 155)

var asteroids_to_destroy: int = 0:
	set(val):
		asteroids_to_destroy = val
		if (is_instance_valid(counter)):
			counter.text = "%d" % [asteroids_to_destroy]

func _ready() -> void:
	spawn_timer.timeout.connect(_timer_done)

func _timer_done() -> void:
	if (asteroids_to_destroy > 0):
		spawn_timer.start()
		var asteroid:= ASTEROIDS.pick_random().instantiate() as Asteroid
		asteroid.position = Vector2(
			randi_range(0, 1) * 320,
			randi_range(0, 80)
		)
		asteroid.destroyed.connect(_asteroid_destroyed)
		task_root.add_child(asteroid)

func _asteroid_destroyed() -> void:
	asteroids_to_destroy -= 1
	if (asteroids_to_destroy == 0):
		task_complete = true
		EventBus.task_completed.emit(task_name)
		toggle_task_visibility()

func restart_task() -> void:
	task_complete = false
	asteroids_to_destroy = randi_range(7, 12)
	spawn_timer.start()

func _physics_process(delta: float) -> void:
	var pos: Vector2 = get_global_mouse_position()
	gun_sprite.frame = clamp(int(pos.x) / 64, 0, 4)

func _unhandled_input(event: InputEvent) -> void:
	if (not task_open or event is not InputEventMouseButton):
		return
	var mouse_event:= event as InputEventMouseButton
	if (not mouse_event.pressed):
		return
	var bullet:= BULLET.instantiate() as Area2D
	bullet.position = GUN_POS
	bullet.rotation_degrees = -90 + ((gun_sprite.frame - 2) * 30)
	task_root.add_child(bullet)
	audio.play()
