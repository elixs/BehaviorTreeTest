extends "res://addons/godot-behavior-tree-plugin/condition.gd"

# Leaf Node
func tick(tick: Tick) -> int:
	if tick.actor.was_hitted:
		return OK
	return FAILED
