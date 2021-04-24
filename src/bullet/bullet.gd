extends KinematicBody2D

export var ACCELERATION: int = 800

var velocity: Vector2 = Vector2()


func init(_direction: Vector2, _position: Vector2) -> void:
	position = _position
	velocity = _direction * ACCELERATION
	

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		
		queue_free()
