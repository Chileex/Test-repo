extends Area2D

var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


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
		$Huball.animation = "move_right"
	if velocity.x > 0 and velocity.y > 0:
		$Huball.animation = "move_right"
	if velocity.x > 0 and velocity.y < 0:
		$Huball.animation = "move_right"
	if velocity.x < 0:
		$Huball.animation = "move_left"
	if velocity.x < 0 and velocity.y > 0:
		$Huball.animation = "move_left"
	if velocity.x < 0 and velocity.y < 0:
		$Huball.animation = "move_left"
	if velocity.y < 0 and velocity.x == 0:
		$Huball.animation = "move_up"
	if velocity.y > 0 and velocity.x == 0:
		$Huball.animation = "move_down"
