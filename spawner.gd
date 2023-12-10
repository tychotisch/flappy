extends Node2D
@onready var timer := $Timer
@onready var bird := $"../Bird"

var Obstacle = preload("res://obstacles.tscn")
var start_spawning = false


func _ready():
	randomize()

func _on_timer_timeout():
	if start_spawning:
		spawn_obstacle()

func spawn_obstacle():
	var obstacle = Obstacle.instantiate()
	add_child(obstacle)
	obstacle.position.y = randi() % 400 + 100
	obstacle.position.x = bird.position.x + 500 

func start_timer():
	timer.start() 

func _on_menus_game_started() -> void:
	start_spawning = true

func _on_bird_died() -> void:
	start_spawning = false
