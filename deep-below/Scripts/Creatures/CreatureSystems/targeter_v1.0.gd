extends Area3D

@export var tick_speed = 0.1##How often the target's position will be updated, increasing it allows the creature to track more accurately, at the cost of being less optimized

signal target_data_update(position, rotation, distance)
signal target_state(state)

@onready var detection_range = $DetectionRange
var current_target : Node

func _on_detector_body_entered(body):
	current_target = body
	target_state.emit(true)

func _on_detector_body_exited(_body):
	current_target = null
	target_state.emit(false)

func distance_calc():
	if current_target:
		var difference : Vector3
		var total_distance : float
		difference = current_target.global_position - global_position
		total_distance = difference.x + difference.y + difference.z
		if total_distance < 0:
			difference *= -1
		return difference

func on_tick():
	if current_target:
		target_data_update.emit(current_target.global_position, current_target.global_rotation, distance_calc())
