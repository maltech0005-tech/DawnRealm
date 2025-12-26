extends CharacterBody2D
@onready var enemy: AnimatedSprite2D = $enemy_sprite
@onready var timer: Timer = $Area2D/Timer

const SPEED = 10.0
var hp = 2
var is_moving = false
var is_attack = false
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

func _physics_process(delta: float) -> void:
	if player:
		if player_inrange:
			run_away()
			velocity = enemy_direction*SPEED*delta
		if is_attack:
			check_is_attack()
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_attack=true
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_attack=false


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = true

func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = false
		
func motion_animation():
	enemy.play("move")
			
func take_damage():
	enemy.play("die")
		
func idle_animation():
	enemy.play("idle")
		
func run_away():
	if not player:
		return
	enemy_direction = (player.global_position - global_position)*-1
	enemy.play("move")
	
func check_is_attack():
	if Input.is_action_pressed("attack"):
		hp-=1
		timer.start(0.5)
		print("hp-1")
		
func _on_timer_timeout() -> void:
	if hp>0:
		check_is_attack()
	else:
		enemy.play("die")
		queue_free()
		
