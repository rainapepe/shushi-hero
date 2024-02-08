extends Node3D
class_name Body

const _LERP_VELOCITY: float = 0.15

@export_category("Objects")

@export var _character: CharacterBody3D = null
@export var animation: AnimationPlayer = null


func apply_rotation(_velocity: Vector3) -> void:
	rotation.y = lerp_angle(
		rotation.y,
		atan2(-_velocity.x, -_velocity.z),
		_LERP_VELOCITY
	)

func animate(_velocity: Vector3) -> void:
	if _velocity:
		if _character.is_running():
			animation.play("Run")
			return
		animation.play("Walk")
		return
	
	animation.play("Idle")
	
