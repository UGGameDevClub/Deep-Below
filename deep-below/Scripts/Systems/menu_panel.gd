@tool
extends Node3D

@export_tool_button("Update","Reload") var updater = Callable(self, "update")
@export var screen_scale = Vector2(1,1)
@export var menu_scene : PackedScene
@onready var screen = $Screen
@onready var scaler = $SubViewportContainer/SubViewport/Scaler
@onready var sub_viewport_container = $SubViewportContainer

var instance
var is_open = false

func _ready():
	update()
	sub_viewport_container.scale.y = 0.01
	sub_viewport_container.modulate = Color(1.0, 1.0, 1.0, 0.0)

func update():
	if !instance and menu_scene:
		instance = menu_scene.instantiate()
		scaler.add_child(instance)
	if !menu_scene and scaler.get_child_count() > 0:
		scaler.get_child(0).queue_free()
	
	if screen_scale:
		screen.scale.x = screen_scale.x
		screen.scale.y = screen_scale.y

func open():
	if !is_open:
		var open_tween = create_tween()
		open_tween.set_trans(Tween.TRANS_SINE)
		open_tween.tween_property(sub_viewport_container,"scale",Vector2(1,1) ,.1)
		open_tween.tween_property(sub_viewport_container,"modulate",Color(1.0, 1.0, 1.0, 1.0),.1)
		is_open = true

func close():
	if is_open:
		var close_tween = create_tween()
		close_tween.set_trans(Tween.TRANS_SINE)
		close_tween.tween_property(sub_viewport_container,"scale",Vector2(1,0.01),.1)
		close_tween.tween_property(sub_viewport_container,"modulate",Color(1.0, 1.0, 1.0, 0.0),.1)
		is_open = false

func _on_input_detector_input_detected(interact_state):
	if interact_state:
		open()
	elif !interact_state:
		close()
