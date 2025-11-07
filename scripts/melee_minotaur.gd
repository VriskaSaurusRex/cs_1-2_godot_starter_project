extends CharacterBody2D
var shoot=false
var chase=false
var melee=false
@onready var player: CharacterBody2D = %Player
func _on_melee_body_entered(body:Node2D)->void:
	melee=true
	chase=false
	shoot=false
	print("melee works")
func _on_melee_body_exited(body:Node2D)->void:
	melee=false
	chase=true
	shoot=false
	print("exit works")
func _on_chase_body_entered(body:Node2D)->void:
	chase=true
	melee=false
	shoot=false
	print("chase works")
func _on_chase_body_exited(body:Node2D)->void:
	pass
