extends Node3D

@onready var arm = $arm
@onready var bowls = [$bowl1, $bowl2, $bowl3]
@onready var lives_counter = $livesCounter

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var coin_bowl = rng.randi_range(0, len(bowls) - 1)
	for bowl in bowls:
		var object: RigidBody3D
		if bowl == bowls[coin_bowl]:
			object = load("res://coin.tscn").instantiate()
			bowl.coin = true
		else:
			object = load("res://orange.tscn").instantiate()
		object.transform.origin = bowl.global_position
		object.transform.origin.y = 1.0
		add_child(object)
		get_tree().create_timer(1.0).timeout.connect(
			func() -> void:
				bowl.object = object
				bowl.take_item()
		)
	
	lives_counter.game_lost.connect(_reset_game)
	arm.win.connect(_reset_game.bind(false))

func _reset_game(lose: bool = true) -> void:
	for bowl in bowls:
		bowl.reset()
	if lose:
		lives_counter.set_lives(lives_counter.max_lives)
