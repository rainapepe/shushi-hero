extends MeshInstance3D

var _offset: Vector3 = Vector3(0, 0.25, 0.25)
var _is_available: bool = true

func change_available_state(state: bool) -> void:
	_is_available = state

func has_available_slot(entity) -> void:
	if _is_available:
		entity.update_state("walking", _offset, global_position)
		change_available_state(false)
		return
	
	entity.update_state("seek_sofa")
