extends Node2D
var playing = true
@onready var left = 
@onready var right = 
@onready var up = 
@onready var down = 

func _process(delta: float) -> void:
	if playing:
		for i in range(10): #missing 3 times kills you
			var randomTime = randi_range(1, 6)
			var randomDirection = randi_range(1, 3) #left/right, up, down
			
			if randomDirection == 1:
				var choice = randi_range(1,2)
				if choice == 1:
					left.play()
				
			elif randomDirection == 2:
				
			elif randomDirection == 3:
				
			
			await wait(randomTime)
		
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
