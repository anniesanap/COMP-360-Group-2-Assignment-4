extends Node3D

@onready var bowls = [$bowl1, $bowl2, $bowl3]

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var coin_bowl = rng.randi_range(0, len(bowls) - 1)
	for bowl in bowls:
		var object: RigidBody3D
		if bowl == bowls[coin_bowl]:
			bowl.add_child(load("res://coin_explosion.tscn").instantiate())
			object = load("res://coin.tscn").instantiate()
		else:
			object = load("res://orange.tscn").instantiate()
		object.transform.origin = bowl.global_position
		object.transform.origin.y = 1.0
		add_child(object)
