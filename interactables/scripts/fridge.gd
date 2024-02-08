extends InteractableObject

@onready var gui: Control = $FridgeContainer

func _interact() -> void:
	_character_ref.change_position_around(self, Vector3.BACK, 2)
	get_tree().call_group("fridge_container", "display", self, true)
	
	pass
