extends Control
@onready var obj_type_1_count: Label = $MarginContainer/HBoxContainer/VBoxContainer/obj_type_1_count
@onready var obj_type_2_count: Label = $MarginContainer/HBoxContainer/VBoxContainer2/obj_type_2_count
@onready var obj_type_3_count: Label = $MarginContainer/HBoxContainer/VBoxContainer3/obj_type_3_count
@onready var total_collected_items: Label = $MarginContainer/HBoxContainer/VBoxContainer4/total_collected_items


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.item_collected_update_ui.connect(update_ui)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_ui():
	# This signal is coming from GameManager when either a new item is registered or an item is collected
	#print("Game UI -> Updating UI")
	if(GameManager.item_collected_dict.has("type_1")):
		obj_type_1_count.text = str(GameManager.item_collected_dict["type_1"]) + "/" + str(GameManager.item_present_dict["type_1"])
	else:
		print("game ui -> type 1 is not present")
	if(GameManager.item_collected_dict.has("type_2")):
		obj_type_2_count.text = str(GameManager.item_collected_dict["type_2"]) + "/" + str(GameManager.item_present_dict["type_2"])
	else:
		print("game ui -> type 2 is not present")
	if(GameManager.item_collected_dict.has("type_3")):
		obj_type_3_count.text = str(GameManager.item_collected_dict["type_3"]) + "/" + str(GameManager.item_present_dict["type_3"])
	else:
		print("game ui -> type 3 is not present")
	total_collected_items.text = str(GameManager.collected_items) + "/" + str(GameManager.total_items)
