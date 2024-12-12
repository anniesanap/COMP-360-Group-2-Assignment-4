extends RichTextLabel

var score: int = 0

func add_score(new_score: int = score + 1) -> void:
	score = new_score
	text = " " + str(score) + " "
