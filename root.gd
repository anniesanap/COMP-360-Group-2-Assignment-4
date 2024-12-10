extends Node3D

@onready var bowls = [$bowl1, $bowl2, $bowl3]

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var coin_bowl = rng.randi_range(0, len(bowls) - 1)
	for bowl in bowls:
		if bowl == coin_bowl:
			bowl.add_child(load("res://coin_explosion.tscn").instantiate())
		else:
			pass
