class_name Player extends CharacterBody2D

@export_range(20, 500, 10) var x_speed: float = 100
@export_range(10, 300, 10) var gravity: float = 50
@export_range(-300, -50, 10) var climb_speed: float = -50

var direction: float = 0.0
var can_climb: bool = false
var can_move: bool = true

func _enter_tree() -> void:
	EventBus.task_opened.connect(_task_opened)
	EventBus.task_closed.connect(_task_closed)

func _task_opened() -> void:
	can_move = false

func _task_closed() -> void:
	can_move = true

func _physics_process(delta: float) -> void:
	x_input()
	apply_velocity()
	if (can_move):
		move_and_slide()

func x_input() -> void:
	direction = Input.get_axis("movement_left", "movement_right")

func apply_velocity() -> void:
	velocity.x = direction * x_speed
	velocity.y += gravity
	if (can_climb and Input.is_action_pressed("movement_up")):
		velocity.y = climb_speed
