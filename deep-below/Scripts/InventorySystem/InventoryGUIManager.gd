extends Control


#@export var GUINode : Node
@export var InvNode : InventoryNode
@export var InvUI : GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	InventoryAutoload.UpdateInvGUI.connect(populate_inventory_ui)
	
	
	if InvNode != null:
		if InvNode.InventoryData != null:
			prepare_inventory_icons()
			populate_inventory_ui()
			
			pass
	else:
		
		#print("A")
		pass
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func prepare_inventory_icons():
	
	if InvUI != null:
		for items in InvUI.get_children():
			
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
	
	pass
