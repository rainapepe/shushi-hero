extends ColorRect
class_name Fps

@export_category("Object")
@export var fps: Label = null

func _physics_process(delta):
	fps.text = str(Engine.get_frames_per_second()) + " - Fps"
