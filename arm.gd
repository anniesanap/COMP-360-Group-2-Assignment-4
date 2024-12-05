extends Node3D

@onready var animation_player = $AnimationPlayer

var arm_grab: Callable = func(): animation_player.play("grab"); rotating = false; animation_player.queue("pickup"); animation_player.queue("idle")

var rotating: bool = false
