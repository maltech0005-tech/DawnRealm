extends CharacterBody2D

@onready var player: AnimatedSprite2D = $AnimatedSprite2D
@onready var gold_amount: Label = $stats/gold_amount
@onready var silver_amount: Label = $stats/silver_amount
@onready var wood_amount: Label = $stats/wood_amount
@onready var hp: TextureProgressBar =$stats/hp_progress
@onready var area_2d: Area2D = $range
@onready var timer: Timer = $range/Timer

const SPEED = 1000.0
var is_moving = false
var is_attack = false
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var player_direction = down
var wood = 0
var gold = 0
var silver = 0
var health=100

func _ready() -> void:
	add_to_group("player")
	life_and_resources()
	
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
		
func life_and_resources():
	hp.value=health
	wood_amount.text= str(wood)
	gold_amount.text= str(gold)
	silver_amount.text= str(silver)

func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		pass
func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		pass

func take_damage(amount: int):
	health-=amount
	hp.value=health
