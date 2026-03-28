extends Node2D
var move
@onready var p = $Player
@onready var pA = $Player/Area2D
@onready var bubble = $CanvasLayer/Bubble
@onready var ding = $ding
@onready var timer = $CanvasLayer/Timer
@onready var scream = $scream

@onready var fadeColor = $CanvasLayer/color
@onready var fadeAnimation = $CanvasLayer/animation

@onready var portrait = $CharliePortrait
@onready var cutscene = $cutscene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	portrait.hide()
	p.moving = false
	fadeColor.show()
	fadeAnimation.play("fadein")
	await fadeAnimation.animation_finished
	
	await bubble.talk("Head Hammy", "Alright! It's officially BEDTIME!")
	await bubble.talk("Head Hammy", "Thank you guys for coming! Especially when you guys are 1/3 of last year's party.")
	
	cutscene.play("anim1")
	await cutscene.animation_finished
	$place.play()
	
	await bubble.talk("Head Hammy", "I drew a lovely piece of Charlie, in memory of him.")
	await bubble.talk("Head Hammy", "Let's keep Charlie's family in our prayers.")
	await bubble.talk("Head Hammy", "It's a terrible thing, what happened to him... ")
	
	cutscene.play("anim2")
	await cutscene.animation_finished
	
	await bubble.talk("Head Hammy", "Anyways, this year will be better!")
	await bubble.talk("Head Hammy", "Just don't wake up last!")
	
	await bubble.talk("Head Hammy", "...Goodnight!")
	
	await wait(1.0)
	$CanvasLayer/CG.show()
	await wait(2.0)
	
	fadeColor.show()
	fadeAnimation.play("fade")
	await fadeAnimation.animation_finished
	
	await wait(2.0)
	
	scream.play()
	await wait(5.0)
	
	
	get_tree().change_scene_to_file("res://code/horror.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func box(name, message):
	p.moving = false
	await bubble.talk(name, message)
	p.moving = true

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
