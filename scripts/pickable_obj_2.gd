extends Node2D

var item_type = "type_2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# register this item in game manager
	if(!GameManager.item_collected_dict.has(item_type)):
		GameManager.item_collected_dict[item_type] = 0
	if(!GameManager.item_present_dict.has(item_type)):
		GameManager.item_present_dict[item_type] = 0
	GameManager.register_item(item_type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_collecting_by_mouse_click(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event is InputEventMouseButton and event.is_pressed()):
		GameManager.item_collected(item_type)
		queue_free()
