extends Node
class_name BaseSlot

var _item: Item = null
var _item_amount: int = 0
var _new_instance: Item = null

@export_category("Objects")
@export var _item_name_label: Label = null
@export var _item_amount_label: Label = null
@export var _item_texture: TextureRect = null

func add_item(_new_item: Item) -> void:
	_item = _new_item
	_item_amount = 1
	
	_new_instance = _item.duplicate(true)
	
	update_item_amount()
	_item_name_label.text = "ITEM - " + _item.name.capitalize()
	_item_texture.texture = _item.texture

func update_item(_type: String) -> void:
	match _type:
		"increase":
			_item_amount += 1
			update_item_amount()
		"decrease":
			_item_amount -= 1
			if _item_amount == 0:
				remove_item()
				return
			update_item_amount()

func remove_item() -> void:
	queue_free()

func update_item_amount() -> void:
	_item_amount_label.text = "AMOUNT - " + str(_item_amount) + "x"
	
func get_item() -> Item:
	return _item

func get_alt_item() -> Item:
	return _new_instance
