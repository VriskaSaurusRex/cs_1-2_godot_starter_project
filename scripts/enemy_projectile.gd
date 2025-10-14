extends Area2D
var speed = 1
var direction
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	queue_free()
	if body.name == "Player":
		body.change_health(-1)
pass
func set_direction(target):
	direction = position.direction_to(target)
func _physics_process(_delta):
	position += speed * direction * _delta
	speed = speed * 1.1
