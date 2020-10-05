extends "res://addons/godot-behavior-tree-plugin/action.gd"

# Leaf Node
func tick(tick: Tick) -> int:
	tick.blackboard.set("target", tick.actor.shooter, tick.tree)
	return OK
