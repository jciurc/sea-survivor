class_name WeightedTabled

var items: Array[Dictionary] = {}


func add_item(item, weight: int):
	items.append({ "item": item, "weight": weight })


func pick_item():
	pass
