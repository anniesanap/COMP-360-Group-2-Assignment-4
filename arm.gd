extends Node3D

@onready var animation_player = $AnimationPlayer

var arm_grab: Callable = func(): animation_player.play("grab"); animation_player.queue("pickup")
