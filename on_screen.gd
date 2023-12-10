extends CanvasLayer

@onready var score_label := $Label
@onready var high_score_label := $High_score
@onready var point_sound := $PointSound

var save_game_path := "user://savedata.save"
var new_score := 0
var high_score := 0

func _ready() -> void:
	load_score()
	high_score_label.text = str(high_score + 1)

func _on_bird_score_added() -> void:
	point_sound.play()
	new_score += 1
	score_label.text = str(new_score)
	if new_score > high_score:
		save_score()
		high_score = new_score
		high_score_label.text = str(high_score)

func save_score() -> void:
	
	var file = FileAccess.open(save_game_path, FileAccess.WRITE)
	file.store_var(high_score)

func load_score() -> void:
	if FileAccess.file_exists(save_game_path):
		var file = FileAccess.open(save_game_path, FileAccess.READ)
		high_score = file.get_var()
	else:
		high_score = 0 

