extends "res://bowl.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.apply_impulse(initialImpulse)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
