extends Node3D

@onready var arm: Node3D = $arm
@onready var bowls: Array[RigidBody3D] = [$bowl1, $bowl2, $bowl3]
@onready var buttons: Array[StaticBody3D] = [$button1, $button2, $button3]
@onready var lives_counter: StaticBody3D = $livesCounter
@onready var score_counter: RichTextLabel = $ui/score
@onready var sun: DirectionalLight3D = $DirectionalLight3D
@onready var environment: WorldEnvironment = $WorldEnvironment

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
		get_tree().create_timer(2.0).timeout.connect(
			func() -> void:
				bowl.object = object
				bowl.take_item()
		)
	lives_counter.game_lost.connect(_lose_game)
	arm.win.connect(_reset_game.bind(false))
	arm.win.connect(score_counter.add_score)

func _reset_game(lose: bool = true) -> void:
	for bowl in bowls:
		bowl.reset()
	if lose:
		lives_counter.set_lives(lives_counter.max_lives)
		for button: StaticBody3D in buttons:
			button.toggle_button(true)
	environment.environment.background_energy_multiplier = 1.0
	sun.light_energy = 1.0

func _lose_game() -> void:
	arm.animation_player.stop()
	sun.light_energy = 0.0
	environment.environment.background_energy_multiplier = 0.1
	for button: StaticBody3D in buttons:
		button.toggle_button(false)
