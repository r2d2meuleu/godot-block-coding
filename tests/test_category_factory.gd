extends GutTest
## Tests for CategoryFactory

const BlockCategory = preload("res://addons/block_code/ui/picker/categories/block_category.gd")


func free_block_list(blocks: Array[Block]):
	var block: Block = blocks.pop_back()
	while block != null:
		block.free()
		block = blocks.pop_back()


func get_category_names(categories: Array[BlockCategory]) -> Array[String]:
	var names: Array[String] = []
	for category in categories:
		names.append(category.name)
	return names


func get_class_category_names(_class_name: String) -> Array[String]:
	var blocks: Array[Block] = CategoryFactory.get_inherited_blocks(_class_name)
	var names: Array[String] = get_category_names(CategoryFactory.get_categories(blocks))
	free_block_list(blocks)
	return names


func test_general_category_names():
	var blocks: Array[Block] = CategoryFactory.get_general_blocks()
	var names: Array[String] = get_category_names(CategoryFactory.get_categories(blocks))
	free_block_list(blocks)
	assert_eq(
		names,
		[
			"Lifecycle",
			"Graphics | Viewport",
			"Sounds",
			"Input",
			"Communication | Methods",
			"Communication | Groups",
			"Loops",
			"Logic | Conditionals",
			"Logic | Comparison",
			"Logic | Boolean",
			"Variables",
			"Math",
			"Log",
		]
	)


const class_category_names = [
	["Node2D", ["Transform | Position", "Transform | Rotation", "Transform | Scale", "Graphics | Modulate", "Graphics | Visibility"]],
	["Sprite2D", ["Transform | Position", "Transform | Rotation", "Transform | Scale", "Graphics | Modulate", "Graphics | Visibility"]],
	["Node", []],
	["Object", []],
]


func test_inherited_category_names(params = use_parameters(class_category_names)):
	assert_eq(get_class_category_names(params[0]), params[1])


func test_unique_block_names():
	var blocks: Array[Block] = CategoryFactory.get_general_blocks()
	var block_names: Dictionary
	for block in blocks:
		assert_does_not_have(block_names, block.block_name, "Block name %s is duplicated" % block.block_name)
		block_names[block.block_name] = block
	free_block_list(blocks)
