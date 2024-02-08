extends Control
class_name InterfaceContainer

const _CHARACTER_SLOT: PackedScene = preload("res://interface/scenes/slots/character_slot.tscn")
const _INTERACTABLE_SLOT: PackedScene = preload("res://interface/scenes/slots/interactable_slot.tscn")

var _interactable: InteractableObject = null

@export_category("Objects")
@export var _interactable_container: VBoxContainer = null
@export var _character_container: VBoxContainer = null

func update_interactable(
	_type: String,
	_item: Item,
	_update_type: String = "increase"
) ->  void:
	match _type:
		"add":
			for children in _interactable_container.get_children():
				var _old_item: Item = (children as BaseSlot).get_item()
				if _old_item == _item:
					update_interactable("update", _item)
					return
					
			var _new_slot = _INTERACTABLE_SLOT.instantiate()
			_interactable_container.add_child(_new_slot)
			_new_slot.add_item(_item)
		"update":
			for children in _interactable_container.get_children():
				var _children_item: Item = (children as BaseSlot).get_item()
				if _children_item == _item:
					children.update_item(_update_type)
			pass
	pass

func update_character(
	_type: String,
	_item: Item,
	_update_type: String = "increase"
) ->  void:
	match _type:
		"add":
			var _new_slot = _CHARACTER_SLOT.instantiate()
			_character_container.add_child(_new_slot)
			_new_slot.add_item(_item)

		"update":
			for children in _character_container.get_children():
				var _children_item: Item = (children as BaseSlot).get_item()
				if _children_item == _item:
					(children as BaseSlot).update_item(_update_type)
					return

func _process(_delta: float) -> void:
	if get_tree().paused and not visible:
		return
		
	if Input.is_action_just_pressed("ui_cancel") and visible:
		_interactable.change_state(true)
		_close()
		
func _close() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func display(_target: InteractableObject, _visibility: bool) -> void:
	if _visibility:
		_change_current_container()
	_interactable = _target
	visible = _visibility
	
func _change_current_container() -> void:
	pass
