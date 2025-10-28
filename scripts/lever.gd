extends Area2D
var on=false
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body):
	if body.name=="Player":
		on=true
		print("lever")
		
