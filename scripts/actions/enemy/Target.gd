extends "res://addons/godot-behavior-tree-plugin/condition.gd"

# Leaf Node
func tick(tick: Tick) -> int:
	if tick.blackboard.get("target", tick.tree):
		return OK
	return FAILED
