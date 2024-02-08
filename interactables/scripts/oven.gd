extends InteractableObject
class_name Oven

@export_category("Variables")
@export var _rotation: float = PI/2
@export var _position: Vector3 = Vector3(-13.388, 0.091, -4.059)

func _interact() -> void:
	_character_ref.change_position(_position, _rotation)
	# fazer chamada na interface
