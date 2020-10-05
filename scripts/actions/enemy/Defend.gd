extends "res://addons/godot-behavior-tree-plugin/action.gd"

# Leaf Node
func tick(tick: Tick) -> int:
	if tick.actor.defending:
		tick.actor.defend()
		return ERR_BUSY
	else:
		return OK

func open(tick: Tick) -> void:
	tick.actor.lvel = Vector2()
	tick.actor.defending = true
	tick.actor.get_node("Sprite").modulate = Color(0, 0, 1)
	tick.actor.get_node("DefendTimer").start()

func close(tick: Tick) -> void:
	tick.actor.was_hitted = false
