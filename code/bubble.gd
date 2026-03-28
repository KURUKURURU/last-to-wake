extends Node2D

@onready var n = $name
@onready var m = $message
@onready var animation = $animation
@onready var bubble = $bubble
@onready var click = $click

func _ready() -> void:
	self.hide()
	bubble.hide()

func talk(name, message):
	
	
	bubble.hide()
	self.show()
	
	n.text = name
	m.text = message
	
	m.visible_ratio = 0.0
	
	animation.play("type")
	await animation.animation_finished
	
	var time = message.length() / 40
	await wait(time)
	
	animation.play("RESET")
	animation.play("slide")
	bubble.show()
	
	await click.pressed
	animation.play("pop")
	await animation.animation_finished
	bubble.hide()
	animation.play("RESET")
	
	n.text = ""
	m.text = ""
	
	self.hide()
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
