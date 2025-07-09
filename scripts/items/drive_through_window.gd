extends Node3D

@onready var label_3d: Label3D = $Label3D
@onready var potions_counter: Node3D = $PotionsCounter
@onready var counter_area: Area3D = $PotionsCounter/Countertop
@onready var customer_spawner: Node3D = $CustomerSpawner
@onready var witch_customer: PackedScene = preload("res://scenes/characters/witch_customer.tscn")

@export var customers: int = 3


func _ready() -> void:
	label_3d.text = str(customers) + " customers left"
	create_customer()
	EventSystem.CUS_order_complete.connect(order_complete)


func _on_countertop_area_entered(area: Area3D) -> void:
	if customers <= 0:
		return
		
	var vial = area.get_parent()
	if vial.is_in_group("base_vial"):
		EventSystem.CUS_passed_vial.emit(vial)


func order_complete() -> void:
	customers -= 1
	
	if customers <= 0:
		label_3d.text = "You have completed the level!"
		return
	else:
		label_3d.text = str(customers) + " customers left"
	
	create_customer()
	

func create_customer() -> void:
	var customer = witch_customer.instantiate()
	customer_spawner.add_child(customer)
	customer.global_transform = customer_spawner.global_transform
