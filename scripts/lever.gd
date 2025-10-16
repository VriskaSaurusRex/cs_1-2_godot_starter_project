extends Node
var on=false
var inrange=false
var player
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		on=true
		print("Lever :3")
func on_body_entered(body):
	if body==player:
		inrange=true
		print("lever")
