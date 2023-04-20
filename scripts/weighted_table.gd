class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum = 0

func add_item(item, weight: int):
	items.append({ "item": item, "weight": weight })
	weight_sum += weight


func pick_item(exclude_items: Array = []):
	var adjusted_items: Array[Dictionary] = []
	var adjusted_weight_sum = weight_sum

	if exclude_items.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		for item in items:
			if item.item in exclude_items:
				continue
			adjusted_items.append(item)
			adjusted_weight_sum += item.weight

	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum = 0
	for item in adjusted_items:
		iteration_sum += item.weight
		if chosen_weight <= iteration_sum:
			print(item)
			return item.item


func remove_item(item_to_remove):
	items = items.filter(func (item): return item.item.id != item_to_remove.id)
	weight_sum = 0
	for item in items:
		weight_sum += item.weight
