extends "res://addons/godot-behavior-tree-plugin/action.gd"

# Leaf Node
func tick(tick: Tick) -> int:
	var target = Manager.blackboard.get("target", tick.tree)
	if tick.actor.global_position.distance_to(target.global_position) > 200:
		tick.actor.follow()
		return ERR_BUSY
	return FAILED

func open(tick: Tick) -> void:
	tick.actor.get_node("Sprite").modulate = Color(1, 0, 0)
