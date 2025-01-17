extends Control

var active = false
@export var id: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_toggle_button_pressed():
	print("button %d pressed" % id)
	active = !active
	print("active %s" % active)
