extends StaticBody3D

@onready var arm = $".."/arm

func press():
	create_tween().tween_property(arm, "rotation:y", PI / 2, 1).set_delay(0.5).set_trans(Tween.TRANS_SPRING)
