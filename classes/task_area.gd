class_name TaskArea extends Area2D

@export var task_root: Node2D

var tween: Tween
var task_open: bool = false
var player_colliding: bool = false
const TASK_INITIAL_OFFSET: Vector2 = Vector2(0, 720)

var task_complete: bool = false

func _enter_tree() -> void:
	set_collision_mask_value(2, true)
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)
	task_root.global_position = TASK_INITIAL_OFFSET
	task_root.hide()

func _body_entered(body: Node2D) -> void:
	if (body is not Player):
		return
	player_colliding = true

func _body_exited(body: Node2D) -> void:
	if (body is not Player):
		return
	player_colliding = false

func _input(event: InputEvent) -> void:
	if (player_colliding
	and event.is_action_pressed("action", false)):
		toggle_task_visibility()

func toggle_task_visibility():
	if (task_complete and not task_open):
		return
	task_open = not task_open
	task_root.global_position = Vector2.ZERO if (not task_open) else TASK_INITIAL_OFFSET
	if (tween != null and tween.is_valid()):
		tween.kill()
	tween = create_tween()
	tween.tween_property(
		task_root,
		"global_position",
		Vector2.ZERO if (task_open) else TASK_INITIAL_OFFSET,
		0.5
	).set_trans(Tween.TRANS_CUBIC)
	if (task_open):
		task_root.show()
		EventBus.task_opened.emit()
	else:
		tween.tween_callback(task_root.hide)
		EventBus.task_closed.emit()

## Override this and instantiate the task here
func restart_task() -> void:
	pass
