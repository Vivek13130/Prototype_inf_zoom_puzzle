extends Control
@onready var total_collected_items: Label = $MarginContainer/HBoxContainer/VBoxContainer4/total_collected_items

var item_labels = {}
# "type1" : "reference to it's label for updating UI" 

func _ready():
	GameManager.item_collected_update_ui.connect(update_ui)
	add_ui_elements()


func add_ui_elements():
	# we are looping through each item type that has been registered 
	# creating a vbox container for that 
	# adding a texture rect and label as child of this vbox 
	# adding this vbox to the UI 
	
	# to generate UI dynamically 
	
	var hbox = $MarginContainer/HBoxContainer
	
	for key in GameManager.item_info.keys():
		print("generating UI for object : " , key)
		var vbox = VBoxContainer.new()
		
		# texture rect : 
		var texture_rect = TextureRect.new()
		var texture = load(GameManager.item_info[key])
		texture_rect.texture = texture
		texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE 
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.expand = true
		texture_rect.custom_minimum_size = Vector2(80, 80)  #fixed minimum size
		texture_rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER  # prevents expansion in y dir
		texture_rect.size_flags_horizontal = Control.SIZE_FILL  # filling hbox  space properly
		
		# label to display the collectible count
		var label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.text = "0 / " + str(GameManager.item_present_dict[key])
		
		hbox.add_child(vbox)
		vbox.add_child(texture_rect)
		vbox.add_child(label)
		
		item_labels[key] = label
	
	update_ui()


func update_ui():
	# This signal is coming from GameManager when either a new item is registered or an item is collected
	for key in GameManager.item_present_dict : 
		if item_labels.has(key):
			if(GameManager.item_collected_dict[key] != GameManager.item_present_dict[key]):
				item_labels[key].text = str(GameManager.item_collected_dict[key]) + " / " + str(GameManager.item_present_dict[key])
			else:
				item_labels[key].text = "DONE"
		else : 
			print("ERROR : this type is not found in UI")
	
	if(GameManager.collected_items != GameManager.total_items):
		total_collected_items.text = str(GameManager.collected_items) + " / " + str(GameManager.total_items)
	else:
		total_collected_items.text = "ALL"
