extends Node2D

var CIRCLE_CENTER_X = 550
var CIRCLE_CENTER_Y = 300

var INNER_CIRCLE_RADIUS: int = 250
var OUTER_CIRCLE_RADIUS: int = 300
var DEGREES_IN_CIRCLE = 360

var NUM_WEDGES = 10

const toggle_switches = preload("res://toggle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _divvy_circle(circle_radius:int, num_wedges: int):
	var wedge_width = DEGREES_IN_CIRCLE / num_wedges
	var wedge_divider_coords = []
	var current_degrees: int = 0
	var center_vec: Vector2 = Vector2(CIRCLE_CENTER_X, CIRCLE_CENTER_Y)
	# var curr_wedge_coord = [center_vec, 
		# Vector2(CIRCLE_CENTER_X - CIRCLE_RADIUS, CIRCLE_CENTER_Y)]
	# wedge_divider_coords.push_back(curr_wedge_coord)
	while current_degrees < DEGREES_IN_CIRCLE: 

		print("current_degrees: " + str(current_degrees))
		var current_rads = deg_to_rad(current_degrees)
		# use radians dum, dum
		var x_coord: float = ((sin(current_rads)) * circle_radius) + CIRCLE_CENTER_X
		var y_coord: float = ((cos(current_rads)) * circle_radius) + CIRCLE_CENTER_Y
		wedge_divider_coords.push_back([center_vec, Vector2(x_coord, y_coord)])
		current_degrees += wedge_width
		
	return wedge_divider_coords
		
func _plot_dividers(wedge_coords):
	# wedge coords should be an array of arrays
	assert(typeof(wedge_coords) == TYPE_ARRAY)
	# assert(typeof(wedge_coords[0] == TYPE_ARRAY))
	for i in wedge_coords: 
		print(i)
		draw_line(i[0], i[1], Color.WHITE_SMOKE, 2.0)
	
func _draw():
	draw_circle(Vector2(CIRCLE_CENTER_X, CIRCLE_CENTER_Y), INNER_CIRCLE_RADIUS, Color.CORNFLOWER_BLUE)
	draw_circle(Vector2(550, 300), 275, Color.TRANSPARENT)
	var dividers = _divvy_circle(INNER_CIRCLE_RADIUS, NUM_WEDGES)
	_plot_dividers(dividers)
	var toggle_coords = _divvy_circle(OUTER_CIRCLE_RADIUS, NUM_WEDGES)
	var toggle_switch_arr = []
	for i in range(len(toggle_coords)): 
		var toggle_button = toggle_switches.instantiate()
		toggle_button.id = i
		add_child(toggle_button)
		toggle_button.set_position(toggle_coords[i][1] + Vector2(-15, -15))
		draw_circle(toggle_coords[i][1], 5, Color.CADET_BLUE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

