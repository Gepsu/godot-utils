class_name Pool extends Resource

var _saved_scenes: Dictionary = {}
var _pool: Dictionary = {}
var _used: Dictionary = {}
var parent: Node

func _init(parent: Node) -> void:
	self.parent = parent
	parent.tree_exited.connect(free_all)

func add_to_pool(key: String, scene: PackedScene, preload_objects: int = 1) -> bool:
	if key in _pool:
		return false
	
	_saved_scenes[key] = scene
	_pool[key] = []
	_used[key] = []
	
	for i in preload_objects:
		instance_new(key, false)
	return true

func get_next(key: String) -> Node:
	if not key in _pool:
		return null
	
	var obj: Node = instance_new(key, true) if _pool[key].is_empty() else _pool[key].pop_back()
	
	_used[key].append(obj)
	toggle_object(obj, true)
	return obj

func put_back(obj: Node) -> bool:
	var key = obj.get_meta("key", "")
	if not key in _pool:
		return false
	
	_pool[key].append(obj)
	_used[key].erase(obj)
	toggle_object(obj, false)
	return true

func instance_new(key: String, for_use_immediately: bool) -> Node:
	var obj = _saved_scenes[key].instantiate()
	obj.set_meta("key", key)
	toggle_object(obj, for_use_immediately)
	if for_use_immediately:
		parent.add_child(obj)
	else:
		parent.call_deferred("add_child", obj)
		_pool[key].append(obj)
	return obj

func toggle_object(obj: Node, yes: bool) -> void:
	obj.set_physics_process(yes)
	obj.set_process(yes)
	obj.set_process_input(yes)
	obj.set_process_unhandled_input(yes)
	obj.set_process_unhandled_key_input(yes)
	obj.visible = yes

func free_all() -> void:
	for key in _pool.keys():
		for obj in _pool[key]:
			obj.queue_free()
		_pool[key] = []
	
	for key in _used.keys():
		for obj in _used[key]:
			obj.queue_free()
		_used[key] = []
