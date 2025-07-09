extends CharacterBody3D

@onready var type_a_label: Label3D = $Orders/TypeALabel
@onready var type_b_label: Label3D = $Orders/TypeBLabel
@onready var type_c_label: Label3D = $Orders/TypeCLabel
@onready var type_d_label: Label3D = $Orders/TypeDLabel
@onready var orders: Node3D = $Orders
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D


@export var min_vial: int = 1
@export var max_vial: int = 3

var requested_orders: Array[Dictionary] = []
var vials_groups: Array[String] = ["type_a_vial", "type_b_vial", "type_c_vial", "type_d_vial"]

func _ready() -> void:
	var material = mesh_instance_3d.get_surface_override_material(0)
	material.albedo_color = Color(RandomNumberGenerator.new().randf_range(0.0,1), 0, 0)
	for vial_type in vials_groups:
		var order_req: Dictionary
		order_req.vials_type = vial_type
		order_req.requested_vials = randi_range(min_vial, max_vial)
		order_req.current_fulfills = 0
		order_req.fulfilled_order = false
		match vial_type:
			"type_a_vial":
				order_req.label = type_a_label
				order_req.type = " A"
				order_req.label.text = str(order_req.requested_vials) + order_req.type
			"type_b_vial":
				order_req.label = type_b_label
				order_req.type = " B"
				order_req.label.text = str(order_req.requested_vials) + order_req.type
			"type_c_vial":
				order_req.label = type_c_label
				order_req.type = " C"
				order_req.label.text = str(order_req.requested_vials) + order_req.type
			"type_d_vial":
				order_req.label = type_d_label
				order_req.type = " D"
				order_req.label.text = str(order_req.requested_vials) + order_req.type
		print("order_req: ", order_req)
		requested_orders.append(order_req)
	EventSystem.CUS_passed_vial.connect(vial_check)
	EventSystem.CUS_order_complete.connect(order_complete)


func vial_check(vial: XRToolsPickable) -> void:
	for order in requested_orders:
		for group in vial.get_groups():
			if group == order.vials_type:
				order.current_fulfills += 1
				order.label.text = str(order.requested_vials - order.current_fulfills) + order.type
				if (order.requested_vials == order.current_fulfills):
					requested_orders.remove_at(requested_orders.find(order))
					if requested_orders.is_empty():
						EventSystem.CUS_order_complete.emit()
				vial.queue_free()
			else:
				print("The order could not be found.")


func order_complete() -> void:
	queue_free()
