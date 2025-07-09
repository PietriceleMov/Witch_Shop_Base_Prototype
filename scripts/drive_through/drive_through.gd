extends Node3D

@onready var customer_spawner: Node3D = $CustomerSpawner
@onready var witch_customer: PackedScene = preload("res://scenes/characters/witch_customer.tscn")

@export var customers: int = 3

func _ready() -> void:
	for customer in customers:
		var witch = witch_customer.instantiate()
		#customer_spawner.add_gizmo()
