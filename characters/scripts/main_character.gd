extends CharacterBody3D
class_name Character

const NORMAL_SPEED: float = 5.0
const SPRINT_SPEED: float = 9.0
const TURBO_SPEED_MULTIPLIER: float = 2.0

var current_speed: float
var current_entity = null
var turbo: bool = false
var is_freezed: bool = false
var can_interact: bool = true

#const Ingredients = preload("res://level/scripts/ingredients.gd")

@export_category("Objects")
@export var body: Body = null
@export var spring_arm_offset: Node3D = null

@onready var turbo_timer = $TurboTimer as Timer
	
func _ready():
	globals.character = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(_delta):
	if is_freezed:
		return

	move()
	move_and_slide()
	body.animate(velocity)

func _input(event):
	if event.is_action_pressed("special") && !turbo:
		print("start turbo")
		start_turbo()

func move() -> void:
	var input_direction: Vector2 = Input.get_vector(
		"move_left", "move_right",
		"move_forward", "move_backward"
	)
	
	var direction: Vector3 = transform.basis * Vector3(
		input_direction.x,
		0,
		input_direction.y
	).normalized()

	is_running()
	is_turbo_activate()
	
	direction = direction.rotated(Vector3.UP, spring_arm_offset.rotation.y)
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		body.apply_rotation(velocity)
		return
		
	velocity.x = move_toward(velocity.x, 0, current_speed)
	velocity.z = move_toward(velocity.z, 0, current_speed)


func is_running() -> bool:
	if Input.is_action_pressed("shift"):
		current_speed = SPRINT_SPEED
		return true
		
	current_speed = NORMAL_SPEED
	return false

func is_turbo_activate():
	if turbo:
		current_speed = current_speed * TURBO_SPEED_MULTIPLIER

func start_turbo():
	turbo = true
	turbo_timer.start()

func _on_turbo_timer_timeout():
	print('timer end')
	turbo = false
	
func freeze(state: bool) -> void:
	body.animation.play("Idle")

	if state:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if not state:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	spring_arm_offset.can_rotate = not state
	is_freezed = state

func change_position(position: Vector3, rotation: float) -> void:
	global_position = position
	body.rotation.y = rotation

func change_position_around(object: Node3D, direction: Vector3, offset: float = 1) -> void:
	var rotated_direction = direction.rotated(Vector3.UP, object.global_rotation.y)
	var position_to = Vector3(
		object.global_position.x + (rotated_direction.x * offset),
		position.y,
		object.global_position.z + (rotated_direction.z * offset),
	)
	
	var rotate_to = object.global_rotation.y
	
	#if direction == Vector3.LEFT:
		#rotate_to = rotate_to - PI/2
	#elif direction == Vector3.FORWARD:
		#rotate_to = rotate_to + PI
	#elif direction == Vector3.RIGHT:
		#rotate_to = rotate_to + PI/2

	rotate_to = lerp_angle(
		object.global_rotation.y,
		atan2(rotated_direction.x, rotated_direction.z),
		1
	)

	change_position(position_to, rotate_to)
