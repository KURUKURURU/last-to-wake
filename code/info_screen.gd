extends Node2D
signal hi


func _on_accept_pressed() -> void:
	self.hide()
	emit_signal("hi")
