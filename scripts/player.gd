extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/projectile.tscn")

var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0
var coins = 0
var is_attacking=false
var attack_cooldown = 0.68
@export var offset : Vector2 = Vector2(0, -25)
@onready var melee_hitbox: Area2D=$Melee
@onready var collision_shape_2d: CollisionShape2D=$Melee/CollisionShape2D
var enemy=null


# TODO: Add health system variables
var maxHealth = 10
var health = maxHealth

func _ready() -> void:
	pass
func on_body_entered(body):
	
		pass
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
			is_attacking=true
	if is_attacking:
		attack_cooldown-=_delta
		if attack_cooldown<0:
			is_attacking=false
			attack_cooldown=0.67
			
	# TODO: Get horizontal input (left/right keys)
	# Input.get_axis checks two keys and gives us a number:
	# - When LEFT is pressed: returns -1.0
	# - When RIGHT is pressed: returns 1.0  
	# - When NOTHING is pressed: returns 0.0
	xDirection = Input.get_axis("ui_left", "ui_right")
	
	# TODO: Get vertical input (up/down keys)  
	# Same idea, but for up and down movement
	yDirection = Input.get_axis("ui_up", "ui_down")
	
	# TODO: Set the player's velocity (how fast they're moving)
	# Godot's CharacterBody2D uses a velocity system
	#velocity is a vector, define it as a product of speed and direction
	velocity.x = xDirection * xSpeed
	velocity.y = yDirection * ySpeed
	#Melee
	if xDirection > 0:
		facing = "right"
		melee_hitbox.position=Vector2(30,0)
	elif xDirection < 0:
		facing = "left"
		melee_hitbox.position=Vector2(-30,0)
	elif yDirection < 0:
		facing = "up"
		melee_hitbox.position=Vector2(0,-30)
	elif yDirection > 0:
		facing = "down"
		melee_hitbox.position=Vector2(0,30)
	# TODO: Update facing direction based on movement
	if xDirection > 0:
		facing = "right"
	elif xDirection < 0:
		facing = "left"
	elif yDirection < 0:
		facing = "up"
	elif yDirection > 0:
		facing = "down"
	
	if Input.is_action_just_pressed("ui_select"):
		shoot()
		attack_cooldown-=_delta
		if attack_cooldown<0:
			attack_cooldown=0.67
	if Input.is_action_just_pressed("ui_accept"):
		is_attacking=true
	if is_attacking==true:
		attack_cooldown-=_delta
	if attack_cooldown<0:
		is_attacking=false
		attack_cooldown=0.67
	# call the animation function
	update_animation()
	
	
	# This is a special Godot function that makes the movement happen
	move_and_slide()

# TODO: Create animation function (add this outside of _physics_process)
func update_animation():
	# TODO: Set the animation based on the facing direction
	if is_attacking:
		_animation_player.play("attack_" + facing)
	else:
		if velocity.is_zero_approx():
			_animation_player.play("idle_" + facing)
		elif !velocity.is_zero_approx():
			_animation_player.play("walk_" + facing)
		



# TODO: Create health change function for interactions
func change_health(_amount:int):
		health += _amount
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		print("Health: ", health)
func change_coins(_amount:int):
	coins += _amount
	print("you have " +str(coins) +" coins")
#INTERACTION TIME BABYYYYYYYYYY B3

func die():
	print("you died")
	queue_free()
# TODO: Create shooting function
func shoot():
	# TODO: Create a new projectile instance
	var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
	projectile_clone.global_position = position + offset
	
	# TODO: Set projectile direction using facing variable
	projectile_clone.set_direction(facing)
	
	# TODO: Add projectile to the game world
	get_tree().get_root().add_child(projectile_clone)
