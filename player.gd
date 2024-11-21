extends Area2D

var speed = 400
var screen_size
var previous_velocity = Vector2.ZERO
@onready var sprite: Node = $Huball
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	var xer = 0
	var yer = 10
	for every in 3:
		print_debug(xer," " , yer)
		yer = xer
		yer += 1
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Huball.play()
	else:
		$Huball.stop()
		
	$Huball.position += velocity * delta
	$Huball.position = $Huball.position.clamp(Vector2.ZERO, screen_size)
	

	if velocity.x > 0:
		if previous_velocity.x > 0 and previous_velocity.y == 0:
			sprite.animation = "move_right"
		elif previous_velocity.x > 0 and previous_velocity.y != 0:
			pass
	if velocity.x < 0:
		if previous_velocity.x < 0 and previous_velocity.y == 0:
			sprite.animation = "move_left"
		elif previous_velocity.x < 0 and previous_velocity.y != 0:
			pass
	if velocity.y > 0:
		if previous_velocity.y > 0 and previous_velocity.x == 0:
			sprite.animation = "move_up"
		elif previous_velocity.y > 0 and previous_velocity.x != 0:
			pass
	if velocity.y < 0:
		if previous_velocity.y < 0 and previous_velocity.x == 0:
			sprite.animation = "move_down"
		elif previous_velocity.y < 0 and previous_velocity.x != 0:
			pass
	
	previous_velocity = velocity
