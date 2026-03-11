@icon("res://Assets/2D/Icons/mineral_item_icon.svg")
extends Node3D

@onready var respawn_timer = $RespawnTimer
@onready var spawn_point = $SpawnPoint
@onready var respawn_animation = $RespawnAnimation

@export var resource_scene : PackedScene##The scene for the item that will be spawned
@export var respawn_time = 20.0##Time until the item will respawn after being removed
var instance

func _ready():
	respawn_timer.wait_time = respawn_time
	respawn()

func item_removed():
	instance = null
	respawn_timer.start()
	respawn_animation.play("RESET")

func respawn():
	if resource_scene and !instance:
		instance = resource_scene.instantiate()
		spawn_point.add_child(instance)
		spawn_point.get_child(0).tree_exited.connect(item_removed)
		respawn_animation.play("grow")
