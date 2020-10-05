extends Area2D

var SPEED = 500

var shooter = null

func _ready():
	connect("body_entered", self, "on_body_entered")


func on_body_entered(body: Node):
	if (shooter.is_in_group("player") and body.is_in_group("enemy")) or \
		(shooter.is_in_group("enemy") and body.is_in_group("player")):
		body.take_damage(shooter)
		if shooter.has_method("hit"):
			shooter.hit(body)
		queue_free()

func _physics_process(delta):
	position += Vector2(cos(rotation), sin(rotation)) * SPEED * delta
