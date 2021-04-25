extends Node2D

signal cleared


func _process(_delta: float) -> void:
	if get_child_count() <= 0:
		emit_signal("cleared")
		queue_free()
