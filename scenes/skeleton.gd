extends CharacterBody2D
@onready var enemy : AnimatedSprite2D = $enemy_sprite

const SPEED = 1000.0
var is_moving = false
var is_attack = false
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var enemy_direction = down
var player=null
var player_inrange = false
var player_position

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	get_direction()
	if is_moving:
		if player_inrange:
			attack()
			velocity = enemy_direction*SPEED*delta
	else:
		if player_inrange:
			attack()
			velocity = enemy_direction*SPEED*delta
	move_and_slide()
	if player_inrange:
		attack()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass # Replace with function body.

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = true

func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = false

	
func get_direction():
	if Input.is_action_pressed("move_left"):
		enemy_direction = left
		enemy.flip_h=true
		is_moving=true
	elif Input.is_action_pressed("move_right"):
		enemy_direction = right
		enemy.flip_h=false
		is_moving=true
	elif Input.is_action_pressed("move_up"):
		enemy_direction = up
		is_moving=true
	elif Input.is_action_pressed("move_down"):
		enemy_direction = down
		is_moving=true
	else:
		is_moving = false
		
func motion_animation():
	if enemy_direction==left:
		enemy.play("walking_side")
	if enemy_direction==right:
		enemy.play("walking_side")
	if enemy_direction==up:
		enemy.play("walking_back")
	if enemy_direction==down:
		enemy.play("walking_front")
			
func take_damage():
	if enemy_direction==left:
		enemy.play("take_damage_side")
	if enemy_direction==right:
		enemy.play("take_damage_side")
	if enemy_direction==up:
		enemy.play("take_damage_back")
	if enemy_direction==down:
		enemy.play("take_damage_front")
		
func idle_animation():
	if enemy_direction==left:
		enemy.play("idle_side")
	if enemy_direction==right:
		enemy.play("idle_side")
	if enemy_direction==up:
		enemy.play("idle_back")
	if enemy_direction==down:
		enemy.play("idle_front")
		
func attack():
	if enemy_direction==left:
		enemy.play("walking_side")
	if enemy_direction==right:
		enemy.play("walking_side")
	if enemy_direction==up:
		enemy.play("walking_back")
	if enemy_direction==down:
		enemy.play("walking_front")
	enemy_direction=(player.global_position-global_position).normalized
	
