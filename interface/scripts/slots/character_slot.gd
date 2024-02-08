extends BaseSlot

func _on_send_button_pressed():
	match globals.current_container:
		"oven":
			pass
		"fridge":
			pass
		"chopping":
			pass
			
	# remover 1 da quantidade do item do personagem
