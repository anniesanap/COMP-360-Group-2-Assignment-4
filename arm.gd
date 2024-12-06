extends Node3D

@onready var animation_player = $AnimationPlayer

var rotating: bool = false

func arm_grab():
	animation_player.play("grab")
	rotating = false; animation_player.queue("pickup")
	animation_player.queue("letgo")

func _ready() -> void:
	animation_player.animation_finished.connect(
		func(animation_name: String) -> void:
			if animation_name == "letgo":
				animation_player.play_backwards("letgo")
				animation_player.queue("idle")
	)
