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
	var velocity = Input.get_vector("left", "right", "up", "down")
	

	if velocity.length() > 0:
		velocity = velocity * speed
		$Huball.play()
	else:
		$Huball.stop()
		
	$Huball.position += velocity * delta
	$Huball.position = $Huball.position.clamp(Vector2.ZERO, screen_size)
	
	#print_debug(velocity)
	
	var normalized = Vector2(1, 1).normalized() * speed
	
	#print_debug(normalized.x, " : ", normalized.y)
	
	if velocity.x > 0 and (previous_velocity.y < normalized.y && previous_velocity.y >= -normalized.y):
		$Huball.animation = "move_right"
	elif velocity.x < 0 and (previous_velocity.y < normalized.y && previous_velocity.y >= -normalized.y):
		$Huball.animation = "move_left"
	elif velocity.y < 0 and (previous_velocity.x < normalized.x && previous_velocity.x >= -normalized.x):
		$Huball.animation = "move_up"
	elif velocity.y > 0 and (previous_velocity.x < normalized.x && previous_velocity.x >= -normalized.x):
		$Huball.animation = "move_down"
	else:
		pass
	# fix some directions for keyboard
	# problem is >= -values? 

		

	
	previous_velocity = velocity
