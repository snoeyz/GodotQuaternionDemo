class_name QuaternionDemo extends Node3D

var ijk_vector: Vector3 = Vector3(1.0, 0.0, 0.0):
	set(value):
		ijk_vector = value
		if quaternion_arrow:
			quaternion_arrow.quaternion = Quaternion(Vector3.RIGHT, value)
		recalculate_quaternion()
var w_degrees: float:
	set(value):
		w_degrees = value
		recalculate_quaternion()
var quat_vector_focus_count: int
var quaternion_rotation: Quaternion:
	set(value):
		quaternion_rotation = value
		if quaternion_godot_cube:
			quaternion_godot_cube.quaternion = value
		if quat_value:
			quat_value.text = "(%.5f, %.5f, %.5f, %.5f)" % [value.x, value.y, value.z, value.w]

# Euler Nodes
@onready var gimbal_x: MeshInstance3D = $GimbalX
@onready var gimbal_z: MeshInstance3D = $GimbalX/GimbalZ
@onready var gimbal_y: MeshInstance3D = $GimbalX/GimbalZ/GimbalY
@onready var x_axis_value: Label = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/EulerControls/XAxisValue
@onready var y_axis_value: Label = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/EulerControls/YAxisValue
@onready var z_axis_value: Label = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/EulerControls/ZAxisValue

# Quaternion Nodes
@onready var w_value: Label = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/QuaternionControls/HBoxContainer2/WValue
@onready var i_value: SpinBox = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/QuaternionControls/HBoxContainer/IValue
@onready var j_value: SpinBox = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/QuaternionControls/HBoxContainer/JValue
@onready var k_value: SpinBox = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/QuaternionControls/HBoxContainer/KValue
@onready var quat_value: Label = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/QuaternionControls/HBoxContainer3/QuatValue
@onready var quaternion_arrow: Node3D = $QuaternionArrow
@onready var quaternion_godot_cube: RigidBody3D = $QuaternionGodotCube
@onready var calculate_quat_button: Button = $CanvasLayer/PanelContainer/MarginContainer/HBoxContainer/QuaternionControls/HBoxContainer/CalculateQuatButton

func _ready() -> void:
	i_value.get_line_edit().focus_entered.connect(_on_quat_vector_value_focused)
	i_value.get_line_edit().focus_exited.connect(_on_quat_vector_value_unfocused)
	j_value.get_line_edit().focus_entered.connect(_on_quat_vector_value_focused)
	j_value.get_line_edit().focus_exited.connect(_on_quat_vector_value_unfocused)
	k_value.get_line_edit().focus_entered.connect(_on_quat_vector_value_focused)
	k_value.get_line_edit().focus_exited.connect(_on_quat_vector_value_unfocused)
	recalculate_quaternion()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if quat_vector_focus_count > 0:
			calculate_quat_button.call_deferred("grab_focus")

func _on_x_axis_slider_value_changed(value: float) -> void:
	gimbal_x.rotation_degrees.x = value
	x_axis_value.text = str(value)

func _on_y_axis_slider_value_changed(value: float) -> void:
	gimbal_y.rotation_degrees.x = value + 90
	y_axis_value.text = str(value)

func _on_z_axis_slider_value_changed(value: float) -> void:
	gimbal_z.rotation_degrees.z = value + 90
	z_axis_value.text = str(value)

func _on_w_slider_value_changed(value: float) -> void:
	w_degrees = value
	w_value.text = str(value)
	recalculate_quaternion()

func _on_quat_vector_value_unfocused() -> void:
	call_deferred("deferred_unfocused")

func _on_quat_vector_value_focused() -> void:
	quat_vector_focus_count += 1

func deferred_unfocused() -> void:
	quat_vector_focus_count -= 1
	if quat_vector_focus_count < 1:
		normalize_quaternion()

func normalize_quaternion() -> void:
	var normalized_vec: Vector3 = Vector3(i_value.value, j_value.value, k_value.value).normalized()
	ijk_vector = normalized_vec
	i_value.value = normalized_vec.x
	j_value.value = normalized_vec.y
	k_value.value = normalized_vec.z

func recalculate_quaternion() -> void:
	quaternion_rotation = Quaternion(ijk_vector, deg_to_rad(w_degrees))
