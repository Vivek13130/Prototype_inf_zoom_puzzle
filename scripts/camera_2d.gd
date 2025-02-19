extends Camera2D

var zoom_min = Vector2(1, 1)
var zoom_max = Vector2(150, 150)

# how much zoom in or out happens per scroll 
var zoom_in_factor = 1.1
var zoom_out_factor = 0.9

# to know if a mouse drag is happening 
var dragging: bool = false

func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.is_pressed():
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.is_pressed():
			zoom_out()
			
		# dragging will happen only by left mouse button 
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed

	#event.relative is an inbuilt function 
	if event is InputEventMouseMotion and dragging:
		# event.relative is in screen space; 
		# we are dividing it by zoom so that when we are zoomed in the drag remains consistent
		position -= event.relative / zoom.x 

func zoom_in():
	# we can smooth out zoom using lerp , but i am not doing it right now 
	var new_zoom = zoom * zoom_in_factor
	new_zoom.x = clamp(new_zoom.x, zoom_min.x, zoom_max.x)
	new_zoom.y = clamp(new_zoom.y, zoom_min.y, zoom_max.y)
	zoom = new_zoom

func zoom_out():
	var new_zoom = zoom * zoom_out_factor
	new_zoom.x = clamp(new_zoom.x, zoom_min.x, zoom_max.x)
	new_zoom.y = clamp(new_zoom.y, zoom_min.y, zoom_max.y)
	zoom = new_zoom
