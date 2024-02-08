extends ColorRect
class_name SettingsContainer

var _world_environment: WorldEnvironment = null

@export_category("Objects")
@export var fps: ColorRect = null

func _ready():
	_world_environment = get_tree().get_nodes_in_group('environment')[0];


	for btn in get_tree().get_nodes_in_group("options_button"):
		if btn is CheckBox:
			btn.pressed.connect(on_button_pressed.bind(btn))
		
		if btn is OptionButton:
			btn.item_selected.connect(on_button_selected.bind(btn))

func _process(delta):
	if globals.character.is_freezed:
		return
	
	if Input.is_action_just_pressed("ui_cancel"):
		visible = not visible
		get_tree().paused = not get_tree().paused
		
		if visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			return
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func on_button_pressed(button: CheckBox) -> void:
	var parent = button.get_parent().get_parent()
	var text_property = parent.name.to_snake_case()
	print(text_property)
	
	match text_property:
		"use_taa":
			get_viewport().use_taa = button.button_pressed
		"display_fps":
			fps.visible = button.button_pressed
		"ssr_enabled":
			_world_environment.environment.ssr_enabled = button.button_pressed
		"ssao_enabled":
			_world_environment.environment.ssao_enabled = button.button_pressed
		"ssil_enabled":
			_world_environment.environment.ssil_enabled = button.button_pressed
		"sdfgi_enabled":
			_world_environment.environment.sdfgi_enabled = button.button_pressed
		
	button.release_focus()

func on_button_selected(button_index: int, button: OptionButton) -> void:
	var parent: HBoxContainer = button.get_parent().get_parent()
	var text_property: String = parent.name.to_snake_case()
	
	match text_property:
		"msaa_3d":
			_update_mass_3d(button_index)
		"screen_space_aa":
			_update_screen_space_aa(button_index)
	
	button.release_focus()

func _update_mass_3d(index: int) -> void:
	var viewport: Viewport = get_viewport()
	
	match index:
		0:
			viewport.msaa_3d = Viewport.MSAA_DISABLED
		1:
			viewport.msaa_3d = Viewport.MSAA_2X
		2:
			viewport.msaa_3d = Viewport.MSAA_4X
		3:
			viewport.msaa_3d = Viewport.MSAA_8X
	
func _update_screen_space_aa(index: int) -> void:
	var viewport: Viewport = get_viewport()
	
	match index:
		0:
			viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		1:
			viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
		
	pass
