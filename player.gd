extends Area2D

var speed = 600
var screen_size
var previous_velocity = Vector2.ZERO
var previous_animation: String
@onready var sprite: Node = $Huball
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$Huball.animation = "idle_down"



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
	
	if velocity.x > 0 and (previous_velocity.y < normalized.y && previous_velocity.y > -normalized.y):
		$Huball.animation = "move_right"
	elif velocity.x < 0 and (previous_velocity.y < normalized.y && previous_velocity.y > -normalized.y):
		$Huball.animation = "move_left"
	elif velocity.y < 0 and (previous_velocity.x < normalized.x && previous_velocity.x > -normalized.x):
		$Huball.animation = "move_up"
	elif velocity.y > 0 and (previous_velocity.x < normalized.x && previous_velocity.x > -normalized.x):
		$Huball.animation = "move_down"
	else:
		pass
	
	previous_velocity = velocity
	previous_animation = $Huball.animation
	if velocity.length() == 0:
		if previous_animation == "move_right":
			$Huball.animation = "idle_right"
		elif previous_animation == "move_left":
			$Huball.animation = "idle_left"
		elif previous_animation == "move_up":
			$Huball.animation = "idle_up"
		elif previous_animation == "move_down":
			$Huball.animation = "idle_down"
		else:
			pass
