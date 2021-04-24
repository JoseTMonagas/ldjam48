extends KinematicBody2D

const Bullet: PackedScene = preload("res://src/bullet/bullet.tscn")

export var ACCELERATION: int = 1200
export var MAX_SPEED: int = 500

var health: int = 100
var speed: int = 0
var velocity: Vector2 = Vector2()


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		var bullet = Bullet.instance()
		bullet.init(Vector2.DOWN, position + Vector2(0, 50))
		get_tree().root.add_child(bullet)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		speed += ACCELERATION * delta
	elif Input.is_action_pressed("ui_left"):
		speed -= ACCELERATION * delta
	else:
		speed = 0
	
	speed = clamp(speed, -MAX_SPEED, MAX_SPEED)
	
	velocity.x = speed
	
	move_and_slide(velocity)


func hit() -> void:
	health -= 1
