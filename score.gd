extends RichTextLabel

var score: int = 0

# Display and keep track of score
func add_score(new_score: int = score + 1) -> void:
	score = new_score
	text = " " + str(score) + " "

func reset_score() -> void:
	score = 0
	text = " " + str(score) + " "
