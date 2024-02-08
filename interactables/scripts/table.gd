extends Area3D

const _STOOL: PackedScene = preload("res://furniture/environment/stool.tscn")

var _chair_position: Array = [
	Vector3(0, 0, 2),
	Vector3(2, 0, 0),
	Vector3(-2, 0, 0),
	Vector3(0, 0, -2)
]

var _chair_position_offset: Array = [
	Vector3(0, 0, 0.4),
	Vector3(0.4, 0, 0),
	Vector3(-0.4, 0, 0),
	Vector3(0, 0, -0.4)
]

var _angle_rotation: Array = [
	0, 
	PI/2,
	-PI + PI/2,
	PI
]

var _offset: Vector3 = Vector3.UP

@export_category("Variables")
@export var _chair_amount: int = 1
@export var _is_available: bool = true

@export_category("Objects")
@onready var _stools: Node3D = $Stools as Node3D

func _ready() -> void:
	for _chair in _chair_amount:
		var _new_chair = _STOOL.instantiate()
		_new_chair.transform.origin = _chair_position[_chair] # + Vector3(randi_range(0, 10), randi_range(0, 10), randi_range(0, 10))
		_stools.add_child(_new_chair)
		
func is_available(entity) -> void:
	if not _is_available:
		entity.update_state("seek_table")
		return
	
	var _index: int = randi() % _stools.get_child_count()
	var _rotation: float = _angle_rotation[_index];
	change_available_state(false)
	_offset = _chair_position[_index] - _chair_position_offset[_index]
	entity.update_state("walking", _offset, global_position, _rotation)

	
func change_available_state(state: bool) -> void:
	_is_available = state
	
