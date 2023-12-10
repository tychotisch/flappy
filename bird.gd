extends CharacterBody2D
class_name Bird

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var bird_image := $AnimatedSprite2D
@onready var jump_sound := $AudioStreamPlayer
@onready var death_sound := $DeathSound
@onready var point_sound :=$PointSound
@onready var animation := $AnimatedSprite2D
@export var rotation_speed = 0.2

signal score_added
signal died

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_angle = deg_to_rad(25)
var score := 0
var game_over := false
var start_game := false

func _physics_process(delta):
	var direction = 0 
	if start_game:
		direction = 1
		velocity.x = direction * SPEED
		velocity.y += gravity * delta
		if Input.is_action_just_pressed("ui_accept") and game_over == false:
			jump()
	
	rotating()
	
	if game_over == true:
		direction = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		die()

	move_and_slide()
	playable_area()

func jump():
	velocity.y = JUMP_VELOCITY
	jump_sound.play()

func rotating():
	if velocity.y > 0:
		rotation += deg_to_rad(10) * rotation_speed
		if rotation > max_angle:
			rotation = max_angle
	elif velocity.y < 0:
		rotation -= deg_to_rad(10) * rotation_speed
		if rotation < max_angle * -1:
			rotation = max_angle * -1

func die():
	death_sound.play()
	animation.stop()
	game_over = true
	rotation = deg_to_rad(90)
	emit_signal("died")

func set_score():
	point_sound.play()
	emit_signal("score_added")

func playable_area():
	if position.y < 10:
		die()
	if position.y > 750:
		die()
		set_physics_process(false)

func _on_menus_game_started() -> void:
	start_game = true
	
