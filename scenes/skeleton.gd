extends CharacterBody2D
@onready var enemy : AnimatedSprite2D = $enemy_sprite

const SPEED = 30.0
var is_moving = false
var is_attack = false
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var enemy_direction = Vector2()
var player_inrange = false
var player_position = Vector2()
var player = null
func _ready() -> void:
	player = get_node("/root/game/player")

func _physics_process(delta: float) -> void:
	if player:
		if player_inrange:
			attack()
			velocity = enemy_direction*SPEED*delta
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		pass # Replace with function body.

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = true

func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = false
		
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
	if player:
		enemy_direction=(player.global_position-global_position)
	if not player:
		print("no node player")
	
