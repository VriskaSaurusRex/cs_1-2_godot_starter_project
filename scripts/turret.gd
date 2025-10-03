extends CharacterBody2D
var max_time=2
var time=max_time
var in_range=false
var player
func _ready():
	
	pass

func _process(delta: float) -> void:
	if in_range:
		time-=delta
		if time<0:
			
			time=max_time


	


func _on_area_2d_body_entered(body: Node2D) -> void:
	player=body
	if body.name=="Player":
		in_range=true
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name=="Player":
		in_range=false
