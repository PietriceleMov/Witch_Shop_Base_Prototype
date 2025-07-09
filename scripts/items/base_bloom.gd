@tool
extends XRToolsPickable
class_name BloomPickable

var harvested_bloom: bool = false


func pick_up(by: Node3D) -> void:
	super.pick_up(by)
	harvested_bloom = true
	EventSystem.ITM_bloom_picked_up.emit()


func let_go(by: Node3D, p_linear_velocity: Vector3, p_angular_velocity: Vector3) -> void:
	super.let_go(by, p_linear_velocity, p_angular_velocity)
	freeze = false
	freeze_mode = RigidBody3D.FREEZE_MODE_STATIC
