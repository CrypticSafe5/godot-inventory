class_name Inventory

class InventoryItem:
	var item: Item
	var count: int

var storage: Array[InventoryItem] = []
@export var count_capacity: int = -1

func add(item: Item) -> void:
	"""
	Add an item to the inventory and returns it's positional index.
	"""
	var index: int
	#var inv_ids = storage.keys()
	var inv_count = len(storage)
	for inv_index in range(inv_count):
		var inv_item = storage[inv_index]
		if inv_item.id == item.id and inv_item.count < item.stack_size:
			# Matching item with stack space
			storage[inv_index].count += 1
			index = inv_index
			break
		elif inv_item == null:
			# Empty slot open
			index = inv_index
			storage[inv_index].count += 1
			break

	# Fallback by appending if space is left
	if index == null and inv_count < count_capacity:
		index = inv_count
		storage.append({
			"item": item,
			"count": 1
		})
	assert(count_capacity < index, "Inventory full, unable to add {}".format([item.name], "{}"))

func remove(index: int, count: int) -> void:
	"""
	Remove an item from the inventory by count
	"""
	var item = storage[index]
	if item == null:
		return
	elif item.count == count or item.count < count:
		# Last item(s)
		storage[index] = null
		return
		
	storage[index].count -= count

func move(source: int, target: int) -> void:
	"""
	Move or swap position of an item with another
	"""
	var tmp = storage[source]
	storage[source] = storage[target]
	storage[target] = tmp
