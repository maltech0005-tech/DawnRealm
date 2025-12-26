extends CharacterBody2D
@onready var animal: AnimatedSprite2D = $animal_sprite
@onready var hp_progress: TextureProgressBar = $hp
@onready var timer: Timer = $Area2D/Timer

const SPEED = 10.0
var hp = 2
var is_moving = false
var is_attack = false
var animal_direction = Vector2()
var player_direction = Vector2()
var player_inrange = false
var player_position = Vector2()
var player = null
func _ready() -> void:
	player = get_node("/root/game/player")
	add_to_group("chicken")
	hp_progress.value=hp
	hp_progress.hide()

func _physics_process(delta: float) -> void:
	if player:
		if player_inrange:
			run_away()
			velocity = animal_direction*SPEED*delta
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
		hp_progress.show()

func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = false
		hp_progress.hide()
		
func motion_animation():
	animal.play("move")
			
func take_damage():
	animal.play("die")
		
func idle_animation():
	animal.play("idle")
		
func run_away():
	if not player:
		return
	animal_direction = (player.global_position - global_position)*-1
	animal.play("move")
	
func check_is_attack():
	if Input.is_action_just_pressed("attack"):
		timer.start(1)
		
func _on_timer_timeout() -> void:
	hp-=1
	hp_progress.value=hp
	if hp>=0:
		check_is_attack()
	else:
		queue_free()
