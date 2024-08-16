class_name QuaternionDemo extends Node3D

@onready var x_axis_value: Label = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/XAxisValue
@onready var gimbal_x: MeshInstance3D = $GimbalX
@onready var gimbal_z: MeshInstance3D = $GimbalX/GimbalZ
@onready var gimbal_y: MeshInstance3D = $GimbalX/GimbalZ/GimbalY
@onready var y_axis_value: Label = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/YAxisValue
@onready var z_axis_value: Label = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/ZAxisValue


func _on_x_axis_slider_value_changed(value: float) -> void:
	gimbal_x.rotation_degrees.x = value
	x_axis_value.text = str(value)

func _on_y_axis_slider_value_changed(value: float) -> void:
	gimbal_y.rotation_degrees.x = value + 90
	y_axis_value.text = str(value)

func _on_z_axis_slider_value_changed(value: float) -> void:
	gimbal_z.rotation_degrees.z = value + 90
	z_axis_value.text = str(value)
