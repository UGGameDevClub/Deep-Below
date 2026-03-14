extends Node3D

@export var item_id = 0##A unique identifier for whatever item is being chosen. Is not tied to the actual mesh being used to represent the item
@onready var mesh_outline = $MeshOutline
@onready var input_detector = $InputDetector

func _ready():
	mesh_outline.visible = false

func _on_input_detector_input_detected(interact_state):
	if visible and interact_state:
		visible = false
		input_detector.disabled = true

func _on_input_detector_body_entered(_body):
	if visible:
		mesh_outline.visible = true

func _on_input_detector_body_exited(_body):
	mesh_outline.visible = false

func _on_visibility_changed():
	if visible:
		input_detector.disabled = false
