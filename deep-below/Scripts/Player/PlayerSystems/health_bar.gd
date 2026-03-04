extends Node2D

@export var max_health = 100.0##Maximum amount of health the player can have
@onready var progress_bar = $ProgressBar

signal damage_taken(amount)
signal died

func _ready():
	progress_bar.max_value = max_health
	progress_bar.value = max_health

func damage(amount):
	var difference = progress_bar.value - amount
	if !difference <= 0:
		progress_bar.value -= amount
		damage_taken.emit(amount)
	elif  difference <= 0:
		died.emit()

func heal(amount):
	progress_bar.value += amount

func manual_health_set(value):
	progress_bar.value = value
