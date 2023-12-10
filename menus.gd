extends CanvasLayer

@onready var start_button := $StartMenu/StartButton
@onready var restart_button := $StartMenu/RestartButton

signal game_started
signal restart_game

func _on_start_button_button_up() -> void:
	emit_signal("game_started")
	start_button.hide()
	restart_button.hide()

func _on_restart_button_button_up() -> void:
	emit_signal("restart_game")
	restart_button.hide()

func _on_bird_died() -> void:
	restart_button.show()





