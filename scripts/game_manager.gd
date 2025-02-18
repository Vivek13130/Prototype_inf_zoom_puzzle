extends Node

var collected_items = 0
var total_items = 0 
var item_present_dict = {} # how many items of each type are present 
var item_collected_dict = {} #how many items of each type we have collected

signal item_collected_update_ui

func register_item(item_type : String):
	# register an item when the level loads 
	print("GameManager -> item registered : ", item_type)
	total_items += 1
	item_present_dict[item_type] += 1
	print("GameManager -> item count  : ", item_present_dict[item_type] )
	
	# we have collectible_type_1 .. _2, _3 now 
	item_collected_update_ui.emit()


func item_collected(item_type : String):
	# update the counters as item is collected
	print("GameManager -> item collected : ", item_type)
	collected_items += 1 
	item_collected_dict[item_type] += 1
	item_collected_update_ui.emit()
