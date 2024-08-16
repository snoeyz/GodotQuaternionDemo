class_name EulerCube extends Node3D

const AXIS_COLORS = [Color.RED, Color.GREEN, Color.BLUE]

var is_ready: bool
var axis_indices: Array[int] = [1, 0, 2]

@onready var outer_gimbal: MeshInstance3D = $OuterGimbal
@onready var outer_axis: MeshInstance3D = $OuterGimbal/OuterAxis
@onready var middle_gimbal: MeshInstance3D = $OuterGimbal/MiddleGimbal
@onready var middle_axis: MeshInstance3D = $OuterGimbal/MiddleGimbal/MiddleAxis
@onready var inner_gimbal: MeshInstance3D = $OuterGimbal/MiddleGimbal/InnerGimbal
@onready var inner_axis: MeshInstance3D = $OuterGimbal/MiddleGimbal/InnerGimbal/InnerAxis

@export var euler_rotation: Vector3
@export var euler_rotation_order: EulerOrder = EULER_ORDER_YXZ:
	set(value):
		euler_rotation_order = value
		update_axis_indices()
		if is_ready:
			pass

func _ready() -> void:
	is_ready = true

func update_axis_indices() -> void:
	match euler_rotation_order:
		EULER_ORDER_XYZ:
			axis_indices = [0, 1, 2]
		EULER_ORDER_XZY:
			axis_indices = [0, 2, 1]
		EULER_ORDER_YXZ:
			axis_indices = [1, 0, 2]
		EULER_ORDER_YZX:
			axis_indices = [1, 2, 0]
		EULER_ORDER_ZXY:
			axis_indices = [2, 0, 1]
		EULER_ORDER_ZYX:
			axis_indices = [2, 1, 0]
