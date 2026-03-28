extends Node2D
@onready var bubble = $Bubble
@onready var color = $color
@onready var animation = $animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color.hide()
	await bubble.talk("You", "Can't believe we're still having our annual Hammy Sleepover!")
	await bubble.talk("You", "Whatever...")
	await bubble.talk("You", "Everything will be alright as long as I don't do what Charlie did last year...")
	
	animation.play("fade")
	await animation.animation_finished
	await wait(2.0)
	get_tree().change_scene_to_file("res://code/bedroom_default.tscn")
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
