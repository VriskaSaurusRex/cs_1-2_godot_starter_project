extends CharacterBody2D
var inrange=false
var chase=false
var melee=false
@onready var player: CharacterBody2D = %Player
func _on_body_entered(melee):
	pass
func _on_body_exited(melee):
	pass
