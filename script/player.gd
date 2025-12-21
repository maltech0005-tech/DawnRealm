extends CharacterBody2D
@onready var player: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 1000.0
var player_direction = Vector2()

func _physics_process(delta: float) -> void:
	get_direction_and_animation()
	velocity = player_direction*SPEED*delta
	
	move_and_slide()
	
func get_direction_and_animation():
	if Input.is_action_pressed("move_left"):
		player_direction = Vector2(-1, 0)
		player.flip_h = true
		player.play("walking_side")
	elif Input.is_action_pressed("move_right"):
		player_direction = Vector2(1, 0)
		player.flip_h = false
		player.play("walking_side")
	elif Input.is_action_pressed("move_up"):
		player_direction = Vector2(0, -1)
		player.play("walking_back")
	elif Input.is_action_pressed("move_down"):
		player_direction = Vector2(0, 1)
		player.flip_h = true
		player.play("walking_front")
	else:
		player_direction = Vector2(0, 0)
		
	if Input.is_action_just_released("move_left"):
		player.flip_h = true
		player.play("idle_side")
	if Input.is_action_just_released("move_right"):
		player.play("idle_side")
		player.flip_h = false
	if Input.is_action_just_released("move_up"):
		player.play("idle_back")
	if Input.is_action_just_released("move_down"):
		player.play("idle_front")
