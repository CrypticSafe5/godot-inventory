class_name Inventory

class InventoryItem:
	var item: Item
	var count: int

var storage: Array[InventoryItem] = []
@export var count_capacity: int = -1

func add(item: Item, count: int) -> void:
	"""
	Add an item to the inventory and returns it's positional index.

	TODO:
	- Add position to target addition of item
	"""
	var index: int
	var inv_count = len(storage)
	for inv_index in range(inv_count):
		var inv_item = storage[inv_index]
		var is_item = inv_item.id == item.id
		if is_item and inv_item.count < item.stack_size:
			# Matching item with stack space
			var stack_count = inv_item.count + count
			if stack_count > item.stack_size:
				# Stack overflow
				var diff = stack_count - item.stack_size
				storage[inv_index].count = item.stack_size
				add(item, diff)
			else:
				# Sub stack addition
				storage[inv_index].count += stack_count
			return
		elif inv_item == null:
			# Empty slot open
			index = inv_index
			break

	# Fallback by appending if space is left
	var should_append = index == null and inv_count < count_capacity
	index = inv_count if should_append else index
	assert(count_capacity < index, "Inventory full, unable to add {}".format([item.name], "{}"))
	storage.append({
		"item": item,
		"count": count
	})

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
