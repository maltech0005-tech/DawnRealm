extends CharacterBody2D
@onready var enemy : AnimatedSprite2D = $enemy_sprite
@onready var hp_progress: TextureProgressBar = $hp
@onready var timer: Timer = $Area2D/Timer

const SPEED = 30.0
var hp=6
var is_moving = false
var is_attacked = false
var is_attacking = false
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var enemy_direction = Vector2()
var player_direction = Vector2()
var player_inrange = false
var player_position = Vector2()
var player = null

func _ready() -> void:
	player = get_node("/root/game/player")
	add_to_group("enemies")
	hp_progress.value=hp
	hp_progress.hide()

func _physics_process(delta: float) -> void:
	if player:
		if player_inrange:
			attack()
			velocity = enemy_direction*SPEED*delta
		if is_attacked:
			check_is_attacked()
		if is_attacking:
			check_is_attacked()
	else:
		velocity = Vector2.ZERO
		idle_animation()
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_attacked=true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_attacked=false


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = true
		hp_progress.show()

func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = false
		hp_progress.hide()
		
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
	if not player:
		return
	enemy_direction = player.global_position - global_position
	var dir = enemy_direction
	
	if abs(dir.x) > abs(dir.y):
		# Horizontal movement
		enemy.play("walking_side")
		enemy.flip_h = dir.x < 0
	else:
		# Vertical movement
		if dir.y < 0:
			enemy.play("walking_back")
		else:
			enemy.play("walking_front")
			
func check_is_attacked():
	if Input.is_action_just_pressed("attack"):
		take_damage()
		timer.start(1)
		
func _on_timer_timeout() -> void:
	hp-=1
	hp_progress.value=hp
	if hp>=0:
		check_is_attacked()
	else:
		queue_free()
