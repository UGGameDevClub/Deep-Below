extends Control
class_name InventoryGUIManager

#@export var GUINode : Node
@export var InvNode : InventoryNode
@export var InvUI : GridContainer
@export var HotbarUI : HBoxContainer


var selecteditem : InventoryButton = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	InventoryAutoload.UpdateInvGUI.connect(populate_inventory_ui)
	
	
	if InvNode != null:
		prepare_button_signals()
		if InvNode.InventoryData != null:
			prepare_inventory_icons(InvUI)
			prepare_inventory_icons(HotbarUI)
			populate_inventory_ui()
			#populate_hotbar_ui()
			
			pass
	else:
		
		#print("A")
		pass
	
	pass # Replace with function body.

func prepare_button_signals():
	
	for nodes in InvUI.get_children():
		
		if nodes is Button:
			
			nodes.connect("pressedwithref",idk)
			
			pass
		
		pass
	
	for nodes in HotbarUI.get_children():
		
		if nodes is Button:
			
			nodes.connect("pressedwithref",idk)
			
			pass
		
		pass
	
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func prepare_inventory_icons(InvNode : Control):
	
	if InvUI != null:
		for items in InvNode.get_children():
			
			items.Itemicon.texture = null
			items.Itemamt.text = " "
					
			
			pass
	
	
	pass


func populate_inventory_ui():
	var InvData = InvNode.get_inventory_data()
	
	if InvUI != null:
		
		#loop through the inventory data
		#if the item slot data is not null, and the itemdata 
		#within isn't null then, set the itemicon in the gui to the item's icon
		#and set the item count in the gui to the item count in the data
		
		
		for items in InvData.SlotArray.size():
			
			if InvData.SlotArray[items] != null:
				if InvData.SlotArray[items].Itemdata != null:
					print(InvData.SlotArray[items].Itemdata)
					InvUI.get_child(items).Itemicon.texture = InvData.SlotArray[items].Itemdata.Itemtexture
					InvUI.get_child(items).Itemamt.text = str(InvData.SlotArray[items].Itemcount)
					pass
				else:
					print("no itemdata found")
					InvUI.get_child(items).Itemicon.texture = null
					InvUI.get_child(items).Itemamt.text = " "
					
					pass
				pass
			
			
			
			pass
		
		
		
		
		pass
	#
	
	populate_hotbar_ui()
	pass



func idk(buttonref : InventoryButton):
	
	
	
	
	
	
	
	#print("idk")
	
	if selecteditem == null:
		
		selecteditem = buttonref 
		print(selecteditem)

		
		pass
	else:
		
		print("swapping items...")
		
		#get the index of the items in the inventory node
		
		
		#
		#var selectedindex = InvNode.get_slot_data(selecteditem.get_index())
		#var otheritemindex = InvNode.get_slot_data(buttonref.get_index())
		#
		#InvNode.swap_slots(selecteditem.get_index(),buttonref.get_index())
		
		InvNode.swap_slots(selecteditem,buttonref)

		selecteditem = null

		pass
	
	
	
	pass
 


func populate_hotbar_ui():
	var InvData = InvNode.get_inventory_data()
	var HotbarData = InvData.HotBar
	##get the hotbar data from the inventory data
	
	for items in HotbarData.size():
		
		if InvData.HotBar[items] != null:
			if InvData.HotBar[items].Itemdata != null:
				print(InvData.HotBar[items].Itemdata)
				HotbarUI.get_child(items).Itemicon.texture = InvData.HotBar[items].Itemdata.Itemtexture
				HotbarUI.get_child(items).Itemamt.text = str(InvData.HotBar[items].Itemcount)
				pass
			else:
				print("no itemdata found")
				HotbarUI.get_child(items).Itemicon.texture = null
				HotbarUI.get_child(items).Itemamt.text = " "
				
				pass
		pass
			
		
		
		pass
	
	##loop through the nodes in the hotbar gui
	
	pass
