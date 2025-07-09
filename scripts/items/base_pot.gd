extends StaticBody3D

@onready var pot_mesh: MeshInstance3D = $MeshInstance3D
@onready var stem_phase_1: RigidBody3D = $StemPhase1
@onready var stem_phase_2: RigidBody3D = $StemPhase2
@onready var stem_phase_3: RigidBody3D = $StemPhase3
@onready var blooming_timer: Timer = $BloomingTimer
@onready var blooming_stem: MeshInstance3D = $StemPhase3/MeshInstance3D3

@export var bloom_scene: PackedScene

var bloom: BloomPickable
var stem_phases: Array[RigidBody3D]
var stem_phase: int:
	set(value):
		if value < stem_phases.size():
			stem_phase = value
		else:
			stem_phase = 0


func _ready() -> void:
	stem_phase = 0
	stem_phases = [stem_phase_1, stem_phase_2, stem_phase_3]
	EventSystem.ITM_bloom_picked_up.connect(bloom_harvest)


func bloom_harvest() -> void:
	if bloom.harvested_bloom:
		blooming_timer.start()


func _on_blooming_timer_timeout() -> void:
	stem_phases[stem_phase].hide()
	stem_phase += 1
	
	if stem_phase == 2:
		print("bloom_scene: ", bloom_scene)
		bloom = bloom_scene.instantiate()
		pot_mesh.add_child(bloom)
		bloom.position.x = -0.1
		bloom.position.y = 1.4
		blooming_timer.stop()
	
	stem_phases[stem_phase].show()
