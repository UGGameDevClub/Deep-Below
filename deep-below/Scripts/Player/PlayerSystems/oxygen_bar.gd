extends Node2D

@onready var progress_bar = $ProgressBar
@export var health_bar_node : Node##When used in the player scene, set this to be the health bar node.
@export var update_speed = 1.0##How often the code will check whether it is underwater, as well as how often it will deal damage once the oxygen runs out
@export_group("Oxygen Settings")
@export var max_oxygen: float = 100.0##The most oxygen the player can have
@export var drain_rate: float = 5.0##How fast the oxygen runs out. At 5 it means it will subtract 5 from the current amount of oxygen from the total every time the code updates, which is as often as is set above as the "update speed"
@export var refill_rate: float = 30.0##How fast the oxygen will refill once the player is out of the water
var is_underwater: bool = false

func _ready():
	progress_bar.max_value = max_oxygen

func suffocate():
	if health_bar_node:
		health_bar_node.damage(5)

func _on_updater_timeout():
	if is_underwater and progress_bar.value > 0:
		progress_bar.value -= drain_rate
	elif !is_underwater and progress_bar > 0 and progress_bar < 100:
		progress_bar.value += refill_rate
	elif progress_bar.value <= 0:
		suffocate()
	
	if progress_bar > 100:
		progress_bar.value = 100
