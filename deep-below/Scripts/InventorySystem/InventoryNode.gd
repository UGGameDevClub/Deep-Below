extends Node
class_name InventoryNode

@export var InventoryData : InventoryRes

func _ready() -> void:
	InventoryAutoload.AddItem.connect(add_item)
	InventoryAutoload.RemoveItem.connect(remove_item)
	
	if InventoryData != null:
		pass
	
func add_item(newitem : SlotData):
	if InventoryData != null:
		for slots in InventoryData.SlotArray:
			if slots.Itemdata == newitem.Itemdata:
				slots.ItemCount += newitem.ItemCount
				InventoryAutoload.UpdateInvGUI.emit()
			else:
				InventoryData.SlotArray.append(newitem)
				InventoryAutoload.UpdateInvGUI.emit()

func remove_item(item : ItemData):
	if InventoryData != null:
		for slotindex in InventoryData.SlotArray.size(): 
			if item == InventoryData.SlotArray[slotindex]:
				InventoryData.SlotArray.remove_at(slotindex)
				InventoryAutoload.UpdateInvGUI.emit()
			else: pass

func get_inventory_data():
	return InventoryData
