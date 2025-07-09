extends Node3D

@export var type_a_requirements: int = 2
@export var type_b_requirements: int = 2
@export var type_c_requirements: int = 2
@export var type_d_requirements: int = 2

@onready var cauldron_core: Node3D = $CauldronCore
@onready var core_area: Area3D = $CauldronCore/CoreArea
@onready var potion_spawner: Node3D = $PotionSpawner
@onready var potion_spawning_point: Marker3D = $PotionSpawner/Marker3D
@onready var type_a_label: Label3D = $TypeALabel
@onready var type_b_label: Label3D = $TypeBLabel
@onready var type_c_label: Label3D = $TypeCLabel
@onready var type_d_label: Label3D = $TypeDLabel

@onready var vial_scene_a: PackedScene = preload("res://scenes/items/vials/vial_a.tscn")
@onready var vial_scene_b: PackedScene = preload("res://scenes/items/vials/vial_b.tscn")
@onready var vial_scene_c: PackedScene = preload("res://scenes/items/vials/vial_c.tscn")
@onready var vial_scene_d: PackedScene = preload("res://scenes/items/vials/vial_d.tscn")

var required_materials_type_a: int = 0
var required_materials_type_b: int = 0
var required_materials_type_c: int = 0
var required_materials_type_d: int = 0


func _ready() -> void:
	type_a_label.text = "0" + " / " + str(type_a_requirements)
	type_b_label.text = "0" + " / " + str(type_b_requirements)
	type_c_label.text = "0" + " / " + str(type_c_requirements)
	type_d_label.text = "0" + " / " + str(type_d_requirements)


func spawn_potion(vial_scene: PackedScene) -> void:
	var vial = vial_scene.instantiate()
	potion_spawner.add_child(vial)
	vial.global_position = potion_spawning_point.global_position


func _on_core_area_area_entered(area: Area3D) -> void:
	var bloom = area.get_parent()
	if bloom.is_in_group("base_bloom"):
		
		if bloom.is_in_group("type_a_bloom"):
			required_materials_type_a += 1
			if required_materials_type_a == type_a_requirements:
				required_materials_type_a = 0
				spawn_potion(vial_scene_a)
			type_a_label.text = str(required_materials_type_a) + " / " +  str(type_a_requirements)
		if bloom.is_in_group("type_b_bloom"):
			required_materials_type_b += 1
			if required_materials_type_b == type_b_requirements:
				required_materials_type_b = 0
				spawn_potion(vial_scene_b)
			type_b_label.text = str(required_materials_type_b) + " / " +  str(type_b_requirements)
		if bloom.is_in_group("type_c_bloom"):
			required_materials_type_c += 1
			if required_materials_type_c == type_c_requirements:
				required_materials_type_c = 0
				spawn_potion(vial_scene_c)
			type_c_label.text = str(required_materials_type_c) + " / " +  str(type_c_requirements)
		if bloom.is_in_group("type_d_bloom"):
			required_materials_type_d += 1
			if required_materials_type_d == type_d_requirements:
				required_materials_type_d = 0
				spawn_potion(vial_scene_d)
			type_d_label.text = str(required_materials_type_d) + " / " +  str(type_d_requirements)
			
		bloom.queue_free()
		
