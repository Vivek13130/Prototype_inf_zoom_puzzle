extends Camera2D

@export var zoom_speed : float = 5
@export var min_zoom = Vector2(1,1)
@export var max_zoom = Vector2(99,99)

var zoom_factor
var zoom_target = Vector2(1,1)
var mouse_pos_before_zoom : Vector2
var zooming : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_pos_before_zoom = get_global_mouse_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if zooming:
		zoom += zoom_speed * delta * Vector2(1,1)
		var mouse_pos_after_zoom = get_global_mouse_position()
		print(mouse_pos_after_zoom)
		position += mouse_pos_after_zoom - mouse_pos_before_zoom
		zooming = false


func _unhandled_input(event: InputEvent) -> void:
	# this is a low priority input handler , 
	#it will only run when the input is not consumed by any other node/scene
	if(event is InputEventMouseButton):
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_factor = 1.1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_factor = 0.9
		
		var new_zoom = zoom_factor * zoom_target
		new_zoom.x = clamp(new_zoom.x, min_zoom.x, max_zoom.x)
		new_zoom.y = clamp(new_zoom.y, min_zoom.y, max_zoom.y)
		
		mouse_pos_before_zoom = get_global_mouse_position()
		print(mouse_pos_before_zoom)
		zoom_target = new_zoom
		zooming = true
		
