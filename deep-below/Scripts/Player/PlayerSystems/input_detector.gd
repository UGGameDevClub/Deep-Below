@icon("res://Assets/2D/Icons/interaction_icon.svg")
extends Area3D

@onready var audio_node = $InteractionSound
@onready var debug_particles = $DebugParticles
@onready var indicator_sprite = $IndicatorSprite
@onready var positioner = $IndicatorSprite/Positioner
@onready var editor_node_marker = $EditorNodeMarker
@onready var movement_disabler = $MovementDisabler/Hitbox

@export_group("Indicator Texture Settings")
@export var indicator_texture : Texture2D##This texture will appear whenever the player is within range of the input detector (Note the texture must be 512x512 or less, otherwise it will be too large and may be clipped out of view)
@export_range(0,2,1) var indicator_anchor : int##Determines were the indicator texture will be placed, 0 is top left, 1 is top center, 2 is top right
@export_group("SFX Settings")
@export var audio_bus : String = "Master"##The bus you want the interaction sound effect to use. Please ensure you spell the name of the bus correctly
@export var interaction_sound : AudioStream##Whatever audio is placed here will play whenever the "input_detected" signal is emitted
@export_category("Extras")
@export var disabled = false
@export var enable_mouse_on_interact = false##If enabled then the mouse is made visible, and will disappear again once the player either exits or is out of range
@export var enable_debug_mode : bool = false##Used for debugging, makes bright particles appear to indicate whenever input has been detected. The "interact state" will also be reflected in the color of the particles, green for true, red for false.
@export var custom_input_keybind : String##If you want the node to detect an input other than interaction(E/left-click), change this to whatever input you want (assuming you've added it to the inputmap in the project settings). Will default to the "interact" keybind if left blank 
var in_range = false
var object_interact_state = false##This is used for determining whether the object is currently being interacted with, for example, if you open a chest, this will be set to true, and will only change to false once the chest is closed
var active_input_keybind : StringName = "interact"
signal input_detected(interact_state)

func _ready():
	movement_disabler.position.y = 999
	if audio_bus:
		$InteractionSound.bus = audio_bus
	if custom_input_keybind:
		active_input_keybind = custom_input_keybind
	else: active_input_keybind = "interact"
	editor_node_marker.visible = false
	debug_particles.visible = true
	indicator_sprite.visible = false
	debug_particles.process_material = debug_particles.process_material.duplicate()
	if interaction_sound:
		audio_node.stream = interaction_sound
	
	if indicator_anchor == 0:
		positioner.play("top_left")
	elif indicator_anchor == 1:
		positioner.play("top_center")
	elif indicator_anchor == 2:
		positioner.play("top_right")
	
	if indicator_texture:
		indicator_sprite.texture = indicator_texture

func _unhandled_input(_event):
	if in_range and Input.is_action_just_pressed("interact") and !disabled:
		audio_node.play()
		if !object_interact_state:
			open()
	if Input.is_action_just_pressed("escape") and object_interact_state:
		close()

func _on_body_entered(_body):
	if !disabled:
		in_range = true
		indicator_sprite.visible = true

func _on_body_exited(_body):
	in_range = false
	indicator_sprite.visible = false
	#if object_interact_state:
	close()

func open():
	if !object_interact_state:
		indicator_sprite.visible = false
		if enable_mouse_on_interact:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
			movement_disabler.position.y = 0
		object_interact_state = true
		debug_particles.process_material.color = Color("00ff00ff")
		if enable_debug_mode:
			debug_particles.emitting = true
		input_detected.emit(object_interact_state)

func close():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	object_interact_state = false
	debug_particles.process_material.color = Color("ff0000ff")
	if enable_debug_mode:
		debug_particles.emitting = true
	input_detected.emit(object_interact_state)
	movement_disabler.position.y = 999
