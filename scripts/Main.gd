extends Node2D

var Player = preload("res://scenes/Player.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("spawn"):
		var player = Player.instance()
		player.global_position = event.global_position
		add_child(player)
