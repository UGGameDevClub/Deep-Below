extends Node3D

@export var item_id = 0##A unique identifier for whatever item is being chosen. Is not tied to the actual mesh being used to represent the item
@onready var mesh_outline = $MeshOutline

func _ready():
	mesh_outline.visible = false

func _on_input_detector_input_detected(_interact_state):
	global_position.y = 5000
	await get_tree().create_timer(1).timeout
	queue_free()##This is temporary code and all it will do is remove this node
				##Will be replaced with actual functionality once inventory system is figured out

func _on_input_detector_body_entered(_body):
	mesh_outline.visible = true

func _on_input_detector_body_exited(_body):
	mesh_outline.visible = false
