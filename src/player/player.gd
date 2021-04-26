extends KinematicBody2D

signal died
signal update_hp(hp)

const Bullet: PackedScene = preload("res://src/bullet/bullet.tscn")


export var ACCELERATION: int = 1200
export var MAX_SPEED: int = 500

var health: int = 100
var speed: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2()

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var hurt_sfx: AudioStreamPlayer2D = $HurtSFX


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		var bullet = Bullet.instance()
		bullet.init(Vector2.DOWN, position + Vector2(0, 100))
		get_tree().root.add_child(bullet)


func _physics_process(delta: float) -> void:
	var mov_x: int = (int(Input.is_action_pressed("ui_right"))
					- int(Input.is_action_pressed("ui_left")))
	var mov_y: int = (int(Input.is_action_pressed("ui_down"))
					- int(Input.is_action_pressed("ui_up")))
	
	if abs(mov_x) > 0:
		speed.x += ACCELERATION * mov_x * delta
	else:
		speed.x = 0
	
	if abs(mov_y) > 0:
		speed.y += ACCELERATION * mov_y * delta
	else:
		speed.y = 0
	
	
	speed = speed.clamped(MAX_SPEED)
	
	velocity = speed
	
	move_and_slide(velocity)


func hit(damage: int = 1) -> void:
	health -= damage
	
	animation_player.play("hit")
	hurt_sfx.play()
	
	emit_signal("update_hp", health)
	
	if health <= 0:
		emit_signal("died")
		queue_free()

