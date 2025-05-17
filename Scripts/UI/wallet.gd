extends Counter

func _ready() -> void:
	Global.coins_updated.connect(set_value)
	_counter.text = str(clamp(File.progress.coins,0,9999999))
	#$Autohide.timeout.connect(close)	
