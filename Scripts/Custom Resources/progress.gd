class_name Progress extends Resource

@export var coins :int:
	set(new_value):
		if coins != new_value:
			coins = new_value
			Global.coins_updated.emit(coins)

#@export var _inventory : Dictionary = {}
#make it public 同时需要多个同名物品一起出现在仓库 字典可能难以做到
@export var inventory : Array = []
@export var equipment : Array = [1,2,3,4]
func _init():
	coins = 0
	#数组里面是字典形式
	inventory = [
		{"name" : "Health Potion","quantity":1},
		{"name" : "Axe"},
		{"name" : "Barbarian Round Shield"},
		#{"name" : "Barbarian Hat"},
		#{"name" : "Barbarian Cape"},
		#{"name" : "Bomb"},
		#{"name" : "Crossbow"},
		#{"name" : "Greataxe"},
		{"name" : "Greatsword"},
		#{"name" : "Heavy Crossbow"},
		#{"name" : "Knife"},
		#{"name" : "Knight Cape"},
		#{"name" : "Knight Helmet"},
		#{"name" : "Mage Cape"},
		#{"name" : "Mage Hat"},
		#{"name" : "Rogue Cape"},
		#{"name" : "Spellbook"},
		#{"name" : "Staff"},
		{"name" : "Sword"}
		#{"name" : "Wand"}
	]

#func add_to_inventory(item : Node3D, quantity : int = 1):
	#if _inventory.has(item.display_name):
		#_inventory[item.display_name] += quantity
	#else:
		#_inventory[item.display_name] = quantity
	#print(_inventory)
