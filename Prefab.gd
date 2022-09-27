extends PackedScene
class_name Prefab

var _parent: Node

func _init(node: Node, free_original := false) -> void:
	assert(node, "Invalid prefab node!")
	_parent = node.get_parent()
	setup_children(node, node)
	if free_original:
		node.queue_free()
	pack(node)

func setup_children(owner: Node, node: Node) -> void:
	for child in node.get_children():
		child.owner = owner
		if child.get_child_count() > 0:
			setup_children(owner, child)

func parent(parent: Node) -> Prefab:
	_parent = parent
	return self

func paste(parent: Node = _parent) -> Node:
	var node: Node = instantiate()
	parent.add_child(node)
	return node

