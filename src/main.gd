extends Node

onready var camera: Camera2D = $Camera2D
onready var ball: KinematicBody2D = $Ball
onready var player: KinematicBody2D = $Player
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		for child in $Group.get_children():
			child.queue_free()


func _on_Group_cleared():
	ball.set_physics_process(false)
	player.set_physics_process(false)
	
	animation_player.play("cleared")
	yield(animation_player, "animation_finished")
	var stages = get_tree().get_nodes_in_group("Stages")
	stages[0].position.x = 0
	
	ball.set_physics_process(true)
	player.set_physics_process(true)
	


func _on_Player_died():
	pass # Replace with function body.
