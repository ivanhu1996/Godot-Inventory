extends SceneManager

@export var _character : CharacterBody3D
@onready var _pause_menu : Control = $"UI/Pause Menu"
@onready var _current_level : Node3D = $Dungeon
@onready var _player : Node = $Player
@onready var _event_manager : EventManager = $"Event Manager"
@onready var _camera : Camera3D = $Barbarian/SpringArm3D/Camera
@onready var _inventory: Panel = $UI/Inventory

func _ready():
	# Position the character at the start position
	_character.position = _current_level.get_player_start_position()
	# Fade in
	super._ready()

func start_event(event, disable_player : bool = true):
	if not event || not event.has_method("run_event"):
		push_warning("Event : " + event + " does not have a run_event method.")
		return
	if disable_player:
		_player.enabled = false
	event.run_event(_event_manager)

func end_event(use_fade : bool = false):
	if _event_manager.camera.current:
		if use_fade:
			await _fade.to_black()
		_camera.make_current()
		_event_manager.camera.reparent(_event_manager)
		if use_fade:
			await _fade.to_clear()
	_player.enabled = true

func toggle_inventory():
	if _inventory.is_open:
		_inventory.close()
	else:
		_inventory.open_as_inventory()
		
# Pause and unpause the game, display pause menu
func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		_pause_menu.open()
	else:
		_pause_menu.close()

# Return to the title scene
func _on_exit_pressed():
	change_scenes("res://Scenes/title.tscn")

# Open settings menu
func _on_settings_pressed():
	_settings_menu.open(_pause_menu)
