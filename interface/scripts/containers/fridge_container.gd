extends InterfaceContainer
class_name FridgeContainer

@export_category("Variables")
@export var _amount: int = 20
@export var _initial_ingredients: Array[Ingredient] = [
	preload("res://item/ingredient/ingredients/avocado.tres"),
	preload("res://item/ingredient/ingredients/crab_sticks.tres"),
	preload("res://item/ingredient/ingredients/cucumber.tres"),
	preload("res://item/ingredient/ingredients/ebi.tres"),
	preload("res://item/ingredient/ingredients/eel.tres"),
	preload("res://item/ingredient/ingredients/fish.tres"),
	preload("res://item/ingredient/ingredients/fish_fillet.tres"),
	preload("res://item/ingredient/ingredients/flounder.tres"),
	preload("res://item/ingredient/ingredients/mackerel.tres"),
	preload("res://item/ingredient/ingredients/nori.tres"),
	preload("res://item/ingredient/ingredients/octopus.tres"),
	preload("res://item/ingredient/ingredients/rice.tres"),
	preload("res://item/ingredient/ingredients/salmon.tres"),
	preload("res://item/ingredient/ingredients/salmon_fish.tres"),
	preload("res://item/ingredient/ingredients/sea_urchin.tres"),
	preload("res://item/ingredient/ingredients/sea_urchin_open.tres"),
	preload("res://item/ingredient/ingredients/shimesaba.tres"),
	preload("res://item/ingredient/ingredients/sliced_cucumber.tres"),
	preload("res://item/ingredient/ingredients/squid.tres"),
	preload("res://item/ingredient/ingredients/tentacle.tres"),
	preload("res://item/ingredient/ingredients/tuna.tres"),
]

func _ready():
	initialize_fridge()
	
	
func initialize_fridge() -> void:
	for i in _amount:
		var _random_item = _initial_ingredients.pick_random()
		var _added: bool = false
		for children in _interactable_container.get_children():
			var _item = (children as BaseSlot).get_item()
			if _item == _random_item:
				update_interactable("update", _random_item)
				_added = true
				break
		
		if !_added:
			update_interactable("add", _random_item)
		
func _change_current_container() -> void:
	globals.current_container = "Fridge"
