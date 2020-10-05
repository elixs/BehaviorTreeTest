extends "res://addons/godot-behavior-tree-plugin/action.gd"

# Leaf Node
func tick(tick: Tick) -> int:
	tick.actor.fire()
	return ERR_BUSY
