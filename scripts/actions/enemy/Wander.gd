extends "res://addons/godot-behavior-tree-plugin/action.gd"

# Leaf Node
func tick(tick: Tick) -> int:
	tick.actor.wander()
	return ERR_BUSY

func open(tick: Tick) -> void:
	tick.actor.get_node("Sprite").modulate = Color(0, 1, 0)
