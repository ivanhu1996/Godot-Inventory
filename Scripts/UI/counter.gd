class_name Counter extends Control

@export var _on_screen_position : Vector2
@export var _off_screen_position : Vector2
@export var _trans_type: Tween.TransitionType
#@export var _ease_type: Tween.EaseType
@export var _duration :float = 1

@onready var _icon: TextureRect = $Icon
@onready var _counter: Label = $Counter
@onready var _autohide: Timer = $Autohide
@onready var _sfx: AudioStreamPlayer = $AudioStreamPlayer
@onready var _particles: CPUParticles2D = $CPUParticles2D

var _tween :Tween
var _is_open : bool
var _stay_open : bool


func open(stay_open : bool = true) -> Signal:
	_stay_open = stay_open
	await _tween_position(_on_screen_position, Tween.EASE_OUT)
	_is_open = true
	return _tween.finished

func set_value(new_value : int):
	if not _is_open:
		await open(false)
	_sfx.play()
	_particles.emitting = true
	await _pulse()
	_counter.text = str(clamp(new_value,0,9999999))
	if not _stay_open:
		_autohide.start()
	
func close() -> Signal:
	_is_open = false
	_tween_position(_off_screen_position , Tween.EASE_IN)
	return _tween.finished

func _pulse() -> Signal:
	if _tween && _tween.is_running():
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(_icon, "custom_minimum_size:y", 46, 0.1)
	_tween.tween_property(_icon, "custom_minimum_size:y", 42, 0.1)
	return _tween.finished
	
	
func _tween_position(new_position : Vector2, ease_type : Tween.EaseType) -> Signal:
	if _tween && _tween.is_running():
		_tween.kill()
	_tween = create_tween().set_trans(_trans_type).set_ease(ease_type)
	_tween.tween_property(self, "position", new_position, _duration)
	return _tween.finished
