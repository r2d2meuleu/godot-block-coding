class_name CategoryFactory
extends Object

const BLOCKS: Dictionary = {
	"basic_block": preload("res://addons/block_code/ui/blocks/basic_block/basic_block.tscn"),
	"control_block": preload("res://addons/block_code/ui/blocks/control_block/control_block.tscn"),
	"parameter_block": preload("res://addons/block_code/ui/blocks/parameter_block/parameter_block.tscn"),
	"statement_block": preload("res://addons/block_code/ui/blocks/statement_block/statement_block.tscn"),
}


static func get_general_categories() -> Array[BlockCategory]:
	var b: Block

	# Entry
	var entry_list: Array[Block] = []
	b = BLOCKS["basic_block"].instantiate()
	b.block_name = "ready_block"
	b.label = "On Ready"
	b.block_type = Types.BlockType.ENTRY
	entry_list.append(b)

	b = BLOCKS["basic_block"].instantiate()
	b.block_name = "process_block"
	b.label = "On Process"
	b.block_type = Types.BlockType.ENTRY
	entry_list.append(b)

	var entry_cat: BlockCategory = BlockCategory.new("Entry", entry_list, Color("fa5956"))

	# Test
	var test_list: Array[Block] = []

	b = BLOCKS["control_block"].instantiate()
	b.label = "repeat 10 times"
	test_list.append(b)

	b = BLOCKS["statement_block"].instantiate()
	b.block_format = "print {text: STRING}"
	b.statement = 'print("{text}")'
	test_list.append(b)
	#
	#b = BLOCKS["parameter_block"].instantiate()
	#b.block_format = "Test string {str: STRING}"
	#b.statement = "{str}"
	#test_list.append(b)

	var test_cat: BlockCategory = BlockCategory.new("Test", test_list, Color("9989df"))

	return [entry_cat, test_cat]


static func add_to_categories(main: Array[BlockCategory], addition: Array[BlockCategory]) -> Array[BlockCategory]:
	var matching := []

	for category in main:
		for add_category in addition:
			if category.name == add_category.name:
				matching.append(category.name)
				for block in add_category.block_list:
					category.block_list.append(block)

	for add_category in addition:
		if !matching.has(add_category.name):
			main.append(add_category)

	return main