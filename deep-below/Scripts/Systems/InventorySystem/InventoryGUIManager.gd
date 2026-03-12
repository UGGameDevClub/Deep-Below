extends Control
class_name InventoryGUIManager

#@export var GUINode : Node
@export var InvNode : InventoryNode
@export var InvUI : GridContainer
@export var HotbarUI : HBoxContainer

var selecteditem : InventoryButton = null

func _ready():
	InventoryAutoload.UpdateInvGUI.connect(populate_inventory_ui)

	if InvNode != null:
		prepare_button_signals()
		if InvNode.InventoryData != null:
			prepare_inventory_icons(InvUI)
			prepare_inventory_icons(HotbarUI)
			populate_inventory_ui()
			#populate_hotbar_ui()
	else:
		pass

func prepare_button_signals():
	for nodes in InvUI.get_children():
		if nodes is Button:
			nodes.connect("pressedwithref",inventory_button_press_handler)

	for nodes in HotbarUI.get_children():
		if nodes is Button:
			nodes.connect("pressedwithref",inventory_button_press_handler)

func prepare_inventory_icons(Inv_Node : Control):
	if InvUI != null:
		for items in Inv_Node.get_children():
			items.Itemicon.texture = null
			items.Itemamt.text = " "

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
				else:
					print("no itemdata found")
					InvUI.get_child(items).Itemicon.texture = null
					InvUI.get_child(items).Itemamt.text = " "
	populate_hotbar_ui()

func inventory_button_press_handler(buttonref : InventoryButton):
	if selecteditem == null:
		selecteditem = buttonref 
		print(selecteditem)
	else:
		print("swapping items...")
		InvNode.swap_slots(selecteditem,buttonref)
		selecteditem = null

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
			else:
				print("no itemdata found")
				HotbarUI.get_child(items).Itemicon.texture = null
				HotbarUI.get_child(items).Itemamt.text = " "
	##loop through the nodes in the hotbar gui
