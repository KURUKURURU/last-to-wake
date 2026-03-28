extends Node2D
signal alarm


#func _ready() -> void:
	#countdown("Bedtime in ", 60)
	
#func _process(delta: float) -> void:
	

# Called when the node enters the scene tree for the first time.
func countdown(message, totalTime):
	$text.text = message + str(totalTime) + " seconds"
	for i in range(totalTime):
		await wait(1.0)
		var time = totalTime - i
		$text.text = message + str(time) + " seconds"
		if time == 1:
			emit_signal("alarm")
			self.hide()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
