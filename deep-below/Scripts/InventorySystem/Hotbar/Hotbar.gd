extends Control
class_name Hotbar

@export var InvNode : InventoryNode
@export var InvUI : Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	InventoryAutoload.UpdateInvGUI.connect(populate_hotbar_ui)
	
	
	if InvNode != null:
		if InvNode.InventoryData != null:
			prepare_inventory_icons()
			populate_hotbar_ui()
			
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



func populate_hotbar_ui():
	var InvData = InvNode.get_inventory_data()
	var HotbarData = InvData.HotBar
	##get the hotbar data from the inventory data
	
	for items in HotbarData.size():
		
		if InvData.HotBar[items] != null:
			if InvData.HotBar[items].Itemdata != null:
				print(InvData.HotBar[items].Itemdata)
				InvUI.get_child(items).Itemicon.texture = InvData.HotBar[items].Itemdata.Itemtexture
				InvUI.get_child(items).Itemamt.text = str(InvData.HotBar[items].Itemcount)
				pass
			else:
				print("no itemdata found")
				InvUI.get_child(items).Itemicon.texture = null
				InvUI.get_child(items).Itemamt.text = " "
				
				pass
		pass
			
		
		
		pass
	
	##loop through the nodes in the hotbar gui
	
	pass
