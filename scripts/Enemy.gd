extends KinematicBody2D

var Bullet = preload("res://scenes/Bullet.tscn")

var SPEED = 100
var FOLLOW_SPEED = 350
var lvel = Vector2()

var wander_target = null
var was_hitted = false
var defending = false
var shooter = null
var can_fire = true

onready var tree = $BehaviorTree

func _ready():
	randomize()
	$DefendTimer.connect("timeout", self, "on_defend_timeout")
	$FireTimer.connect("timeout", self, "on_fire_timeout")

func on_defend_timeout():
	defending = false

func on_fire_timeout():
	can_fire = true

func _physics_process(delta):
	if lvel.length_squared() > 10:
		rotation = lvel.angle() + PI / 2
	
	tree.tick(self, Manager.blackboard)

func take_damage(shooter):
	was_hitted = true
	self.shooter = shooter

func hit(body):
	var target = Manager.blackboard.get("target", tree)
	if body == target:
		Manager.blackboard.set("target", null, tree)


func move_to(target: Vector2, speed):
	var tvel = (target - global_position).normalized() * speed
	if global_position.distance_to(target) < SPEED * get_physics_process_delta_time():
		tvel = Vector2()
	lvel = lerp(lvel, tvel, 0.5)
	lvel = move_and_slide(lvel)
	if get_slide_count() > 0:
		lvel = Vector2()

func wander():
	if not wander_target:
		var vs = get_viewport_rect().size
		wander_target = Vector2(randf() * vs.x * 0.8, randf() * vs.y * 0.8) + vs * 0.1
	move_to(wander_target, SPEED)
	if lvel.length_squared() <= 10:
		wander_target = null

func defend():
	rotation += PI / 10

func follow():
	var target = Manager.blackboard.get("target", tree)
	move_to(target.global_position, FOLLOW_SPEED)

func fire():
	var target = Manager.blackboard.get("target", tree)
	var angle = (target.global_position - global_position).angle()
	rotation = angle + PI / 2
	if can_fire:
		can_fire = false
		$FireTimer.start()
		var bullet = Bullet.instance()
		bullet.shooter = self
		bullet.global_position = global_position
		bullet.global_rotation = angle
		bullet.modulate = Color(1, 0, 0)
		get_parent().add_child(bullet)
