extends CharacterBody2D
var shoot_range=false
var chase=false
var melee_range=false
var melee=false
@onready var player: CharacterBody2D = %Player
var projectile_original = preload("res://scenes/enemy_projectile.tscn")
var target
func _on_melee_body_entered(body:Node2D)->void:
	melee_range=true
	chase=false
	shoot_range=false
	print("melee works")
func _on_melee_body_exited(body:Node2D)->void:
	melee_range=false
	chase=true
	shoot_range=false
	print("exit works")
func _on_chase_body_entered(body:Node2D)->void:
	chase=true
	melee_range=false
	shoot_range=false
	print("chase works")
func _on_chase_body_exited(body:Node2D)->void:
	chase=false
	melee_range=false
	shoot_range=true
func _on_shoot_body_entered(body:Node2D)->void:
	if body.name=="player":
		player=body
		chase=false
		melee_range=false
		shoot_range=true
func _on_shoot_body_exited(body:Node2D)->void:
	if body.name=="Player":
		player=body
		chase=false
		melee_range=false
		shoot_range=false
func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(target.position)
