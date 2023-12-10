extends Area2D


func _on_body_exited(body):
	if body.has_method("set_score"):
		body.set_score()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
