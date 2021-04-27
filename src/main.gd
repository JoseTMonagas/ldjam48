extends Node

onready var camera: Camera2D = $Camera2D
onready var ball: KinematicBody2D = $Ball
onready var player: KinematicBody2D = $Player
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var background_pivot: Node2D = $Background
onready var tween: Tween = $Tween
onready var HUD: Control = $HUD


func _ready():
	player.connect("update_hp", self, "on_update_hp")


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		for child in $Group.get_children():
			child.queue_free()


func _move_background() -> void:
	var start_position: float = background_pivot.position.y
	var move = tween.interpolate_property(background_pivot,
		"position.y",
		start_position,
		start_position - 600,
		1.4,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN)
	tween.start()


func _on_Group_cleared():
	ball.set_physics_process(false)
	player.set_physics_process(false)
	
	animation_player.play("cleared")
	yield(animation_player, "animation_finished")
	var stages = get_tree().get_nodes_in_group("Stages")
	stages[0].position.x = 0
	player.hp = 100
	player.emit_signal("update_hp")
	
	ball.set_physics_process(true)
	player.set_physics_process(true)


func _on_Player_died():
	get_tree().change_scene("res://src/gameover/gameover.tscn")


func on_update_hp(health):
	health = player.health
	HUD.get_hp(health)
