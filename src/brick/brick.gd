extends StaticBody2D

signal yeeted

const Bullet: PackedScene = preload("res://src/bullet/bullet.tscn")

enum Type {
	BASE,
	VERTICAL_RAY,
	HORIZONTAL_RAY,
	CROSS_RAY
}

export(Type) var BRICK_TYPE


func _ready() -> void:
	assert(BRICK_TYPE != null)


func hit() -> void:
	match(BRICK_TYPE):
		Type.BASE:
			pass
		Type.VERTICAL_RAY:
			_fire([Vector2.UP, Vector2.DOWN])
		Type.HORIZONTAL_RAY:
			_fire([Vector2.LEFT, Vector2.RIGHT])
		Type.CROSS_RAY:
			_fire([Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT])
	
	emit_signal("yeeted")
	queue_free()


func _spawn_bullet(direction: Vector2) -> void:
	var bullet = Bullet.instance()
	bullet.init(direction, position + direction * 50)
	get_tree().root.add_child(bullet)


func _fire(directions: Array) -> void:
	for direction in directions:
		_spawn_bullet(direction)
	
	emit_signal("yeeted")
	queue_free()
