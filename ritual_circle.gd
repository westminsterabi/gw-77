extends Node2D

const CIRCLE_CENTER_X = 550
const CIRCLE_CENTER_Y = 300

const INNER_CIRCLE_RADIUS: int = 250
const OUTER_CIRCLE_RADIUS: int = 275
const DEGREES_IN_CIRCLE = 360

const NUM_WEDGES = 10
const DOT_OFFSET = Vector2(-15, -15)

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
		
func plot_toggles(toggle_coords):
	# iterate through the list of coordinates
	for i in range(len(toggle_coords)): 
		# make a new switch and assign its ID to current idx
		var toggle_button = toggle_switches.instantiate()
		toggle_button.id = i
		add_child(toggle_button)
		# set the position of the new button to our point
		toggle_button.set_position(toggle_coords[i][1] + DOT_OFFSET)
		# draw a little dot as well
		draw_circle(toggle_coords[i][1], 10, Color.DARK_RED)
	

func _draw():
	draw_circle(Vector2(CIRCLE_CENTER_X, CIRCLE_CENTER_Y), INNER_CIRCLE_RADIUS, Color.DARK_RED)
	draw_circle(Vector2(550, 300), 275, Color.TRANSPARENT)
	var dividers = _divvy_circle(INNER_CIRCLE_RADIUS, NUM_WEDGES)
	_plot_dividers(dividers)
	var toggle_coords = _divvy_circle(OUTER_CIRCLE_RADIUS, NUM_WEDGES)
	plot_toggles(toggle_coords)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

