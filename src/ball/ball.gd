extends KinematicBody2D

export var acceleration: int = 100

var velocity: Vector2 = Vector2()


func _ready() -> void:
	velocity = Vector2(-1, 1) * acceleration


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	
	if collision:
		$BounceSFX.play()
		velocity = velocity.bounce(collision.normal)
		
		if collision.collider.has_method("hit"):
			collision.collider.hit(20)
