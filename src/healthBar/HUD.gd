extends Control


onready var hp: TextureProgress = $MarginContainer/VBoxContainer/HBoxContainer/HBoxContainer2/hp


func get_hp(health):
	print("get hp is being executed")
	hp.value=health
