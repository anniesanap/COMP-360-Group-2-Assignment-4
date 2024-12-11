extends RichTextLabel

@onready var corner_background: ColorRect = $cornerBackground
@onready var corner_orig_alpha: float = corner_background.modulate.a

func _ready() -> void:
	get_tree().create_timer(7.0).timeout.connect(
		func() -> void:
			create_tween().tween_property(self, "modulate:a", 0.0, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
			create_tween().tween_property(corner_background, "modulate:a", 0.0, 1.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	)
