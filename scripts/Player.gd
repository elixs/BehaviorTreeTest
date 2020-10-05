extends KinematicBody2D

var Bullet = preload("res://scenes/Bullet.tscn")

var lvel = Vector2()

var SPEED = 400

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		fire()
	
	var tvel = Vector2(
		Input.get_action_strength("move_rigth") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	lvel = lerp(lvel, tvel * SPEED, 0.5)
	
	lvel = move_and_slide(lvel)
	
	rotation = (get_global_mouse_position() - global_position).angle() + PI / 2
	

func fire():
	var bullet = Bullet.instance()
	bullet.shooter = self
	bullet.global_position = global_position
	bullet.global_rotation = (get_global_mouse_position() - global_position).angle()
	get_parent().add_child(bullet)
	
func take_damage(shooter):
	queue_free()
