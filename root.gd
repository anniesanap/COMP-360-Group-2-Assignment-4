extends Node3D

@onready var arm: Node3D = $arm
@onready var bowls: Array[RigidBody3D] = [$bowl1, $bowl2, $bowl3]
@onready var buttons: Array[StaticBody3D] = [$button1, $button2, $button3]
@onready var lives_counter: StaticBody3D = $livesCounter
@onready var score_counter: RichTextLabel = $ui/score
@onready var sun: DirectionalLight3D = $DirectionalLight3D
@onready var environment: WorldEnvironment = $WorldEnvironment
@onready var player: CharacterBody3D = $player
@onready var lose_text: RichTextLabel = $ui/loseText

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	# Generate ground planes
	var new_node: Node3D = Node3D.new()
	new_node.transform = get_node("ground/groundMesh").transform
	new_node.transform.origin += Vector3(0.0, 0.4, 0.0)
	new_node.name = "groundNode"    
	new_node.set_script(load("res://ground_node.gd"))
	$ground.add_child(new_node)
	
	# Choose random bowl to put coin under
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
		bowl.object = object
	
	# Connect signals
	lives_counter.game_lost.connect(_lose_game)
	arm.win.connect(_reset_game)
	arm.win.connect(score_counter.add_score)
	
	_reset_game()

# Move bowls to start position and shuffle them
func _reset_game() -> void:
	for bowl in bowls:
		bowl.add_collision_exception_with(player)
		# Reset position and item position
		bowl.reset()
	
	arm.animation_player.play("idle")
	environment.environment.background_energy_multiplier = 1.0
	sun.light_energy = 1.0
	# Disable buttons
	for button: StaticBody3D in buttons:
		button.toggle_button(false)
	# Launch bowls upwards to see where each item is
	get_tree().create_timer(2.5).timeout.connect(
		func() -> void:
			for bowl: RigidBody3D in bowls:
				bowl.spawn_item()
				bowl.apply_impulse(bowl.initial_impulse)
	)
	# Remove item under bowls from tree, and then shuffle
	get_tree().create_timer(4.5).timeout.connect(
		func() -> void:
			for bowl: RigidBody3D in bowls:
				bowl.take_item()
			shuffle(0)
	)

# Animation sequence to play when no lives left
func _lose_game() -> void:
	arm.animation_player.stop()
	sun.light_energy = 0.0
	environment.environment.background_energy_multiplier = 0.1
	for button: StaticBody3D in buttons:
		button.toggle_button(false)
	get_tree().create_timer(5.0).timeout.connect(
		func() -> void:
			player.velocity.y = 500
			lose_text.visible = true
			get_tree().create_timer(7.0).timeout.connect(
				func() -> void:
					score_counter.reset_score()
					lose_text.visible = false
					player.global_position = Vector3(-3, 1, 0)
					_reset_game()
					player.velocity.y = 0.0
					lives_counter.set_lives(lives_counter.max_lives, lives_counter.max_lives)
			)
	)

# Shuffle bowls randomly, up to 17 times recursively with increasing speed, and re-activate buttons at the end
func shuffle(current_round: int) -> void:
	if current_round == 0:
		for bowl: RigidBody3D in bowls:
			if bowl.object.is_inside_tree():
				bowl.take_item()
	var bowl_1: int = rng.randi_range(0, 2)
	var bowl_2: int = rng.randi_range(0, 2)
	while bowl_1 == bowl_2:
		bowl_2 = rng.randi_range(0, 2)
	var bowl_1_orig_position: Vector3 = bowls[bowl_1].global_position
	var bowl_2_orig_position: Vector3 = bowls[bowl_2].global_position
	var swap_tween: Tween = create_tween()
	swap_tween.set_parallel()
	swap_tween.tween_property(bowls[bowl_1], "global_position", bowl_2_orig_position, 4 / float(current_round + 6)).set_trans(Tween.TRANS_CUBIC)
	swap_tween.tween_property(bowls[bowl_2], "global_position", bowl_1_orig_position, 4 / float(current_round + 6)).set_trans(Tween.TRANS_CUBIC)
	swap_tween.chain().tween_callback(func() -> void: bowls[bowl_1].object.transform.origin = bowl_2_orig_position)
	swap_tween.tween_callback(func() -> void: bowls[bowl_2].object.transform.origin = bowl_1_orig_position)
	if current_round < 17:
		swap_tween.chain().tween_callback(shuffle.bind(current_round + 1))
	else:
		swap_tween.chain().tween_callback(
			func() -> void:
				for bowl: RigidBody3D in bowls:
					bowl.remove_collision_exception_with(player)
					bowl.initial_transform = bowl.transform
				for button: StaticBody3D in buttons:
					button.toggle_button(true)
		)
