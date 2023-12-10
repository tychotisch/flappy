extends Node2D

func _on_menus_restart_game() -> void:
	get_tree().reload_current_scene()
