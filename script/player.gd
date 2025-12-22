extends CharacterBody2D
@onready var player: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 1000.0
var is_moving = false
var is_attack = false
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var player_direction = down
func _physics_process(delta: float) -> void:
	get_direction()
	if is_moving:
		motion_animation()
		velocity = player_direction*SPEED*delta
	else:
		velocity=Vector2(0, 0)
	if velocity==Vector2(0, 0):
		if Input.is_action_pressed("attack"):
			attack()
		else:
			idle_animation()
	move_and_slide()
	
func get_direction():
	if Input.is_action_pressed("move_left"):
		player_direction = left
		player.flip_h=true
		is_moving=true
	elif Input.is_action_pressed("move_right"):
		player_direction = right
		player.flip_h=false
		is_moving=true
	elif Input.is_action_pressed("move_up"):
		player_direction = up
		is_moving=true
	elif Input.is_action_pressed("move_down"):
		player_direction = down
		is_moving=true
	else:
		is_moving = false
		
func motion_animation():
	if player_direction==left:
		player.play("walking_side")
	if player_direction==right:
		player.play("walking_side")
	if player_direction==up:
		player.play("walking_back")
	if player_direction==down:
		player.play("walking_front")
			
func attack():
	if player_direction==left:
		player.play("slash_side")
	if player_direction==right:
		player.play("slash_side")
	if player_direction==up:
		player.play("slash_back")
	if player_direction==down:
		player.play("slash_front")
		
func idle_animation():
	if player_direction==left:
		player.play("idle_side")
	if player_direction==right:
		player.play("idle_side")
	if player_direction==up:
		player.play("idle_back")
	if player_direction==down:
		player.play("idle_front")
