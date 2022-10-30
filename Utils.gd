class_name Utils extends Node

## Returns file names in folder
static func get_files_in_folder(path: String, extension: String = "", full_path: bool = false, starts_with: String = "", max_items: int = 999) -> Array:
	var files = []
	var dir = DirAccess.open(path)
	
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if extension != "":
			if file.get_extension() == extension:
				if file.begins_with(starts_with):
					files.append(path + file if full_path else file)
		else:
			if file.begins_with(starts_with):
				files.append(path + file if full_path else file)
		file = dir.get_next()
		if files.size() == max_items:
			return files
	dir.list_dir_end()
	
	return files

## Makes a simple 2d array and fills it with whatever default value is set to
static func create_2d_array(width: int, height: int, default_value = null) -> Array:
	var array: Array
	for x in width:
		for y in height:
			var second_array: Array
			second_array.resize(height)
			second_array.fill(default_value)
			array.append(second_array)
	return array

## Number has to be less than 1.0
static func chance(number: float) -> bool:
	return randf_range(0, 1) <= number

## Picks a random item from an array
static func array_random(array: Array):
	return array[randi() % array.size()]

## Checks if the difference between numbers is below the threshold
static func numbers_are_close(a: float, b: float, threshold: float) -> bool:
	return abs(a - b) <= threshold

## Clamps control nodes to viewport
static func clamp_to_viewport(viewport: Viewport, control: Control, margin: float = 0.0) -> void:
	control.global_position = control.global_position.clamp(
		Vector2.ONE * margin, 
		viewport.get_visible_rect().end - control.size - Vector2.ONE * margin
	)

## Better connect function
static func reconnect(_signal: Signal, callable: Callable, flags := 0) -> void:
	if _signal.is_connected(callable):
		_signal.disconnect(callable)
	_signal.connect(callable, flags)

## Better pivot offset. Sets it according to the size. How much could be either a Vector2, int or a float
static func offset_pivot(control: Control, how_much = Vector2.ZERO) -> void:
	if not (how_much is float or how_much is int or how_much is Vector2):
		printerr("Set the pivot offset value to either Vector2, int or a float!")
		return
	if how_much is float or how_much is int:
		how_much = Vector2.ONE * how_much
	control.pivot_offset = control.size * how_much

## Prints an array in a more readable fashion
static func print_array(array: Array) -> void:
	var s := ""
	for i in array:
		s += str(i) + "\n"
	print(s.trim_suffix("\n"))

## Blatantly stolen from: https://observablehq.com/@scarysize/finding-random-points-in-a-polygon Thank you!
static func get_random_point_in_polygon(polygon: PackedVector2Array) -> Vector2:
	# Get triangles
	var points: Array = Geometry2D.triangulate_polygon(polygon)
	var triangles: Array
	while not points.is_empty():
		triangles.append([polygon[points.pop_back()], polygon[points.pop_back()], polygon[points.pop_back()]])
	
	var get_triangle_area: Callable = func(tri: Array):
		return 0.5 * (
			(tri[1].x - tri[0].x) * (tri[2].y - tri[0].y) -
			(tri[2].x - tri[0].x) * (tri[1].y - tri[0].y)
		)
	
	# Generate distribution
	var total_area = triangles.reduce(func(sum, tri): return sum + get_triangle_area.call(tri), 0)
	var cumulative_distribution = []
	
	for i in triangles.size():
		var last_value = 0 if i == 0 else cumulative_distribution[i - 1]
		var next_value = last_value + get_triangle_area.call(triangles[i]) / total_area
		cumulative_distribution.append(next_value)
	
	# Choose random triangle
	var rnd = randf_range(0, 1)
	var random_triangle = cumulative_distribution.filter(func(i): return i > rnd).front()
	var random_index = cumulative_distribution.find(random_triangle)
	
	# Calculate random point
	var wb = randf_range(0, 1)
	var wc = randf_range(0, 1)
	
	if wb + wc > 1:
		wb = 1 - wb
		wc = 1 - wc
	
	var tri = triangles[random_index]
	var rb_x = wb * (tri[1].x - tri[0].x)
	var rb_y = wb * (tri[1].y - tri[0].y)
	var rc_x = wc * (tri[2].x - tri[0].x)
	var rc_y = wc * (tri[2].y - tri[0].y)
	
	var r_x = rb_x + rc_x + tri[0].x
	var r_y = rb_y + rc_y + tri[0].y
	return Vector2(r_x, r_y)

## Enumerable
static func enumerate(array: Array, start: int = 0, end: int = array.size(), step: int = 1) -> Enumerable:
	return Enumerable.new(array, start, end, step)

class Enumerable extends Resource:
	var array: Array
	var start: int
	var end: int
	var step: int
	var count: int: get = get_index
	var idx: int: get = get_index
	var current: get = get_item
	var item: get = get_item
	
	func _init(array: Array, start: int, end: int, step: int) -> void:
		self.array = array
		self.start = clamp(start, 0, array.size())
		self.end = min(end, array.size())
		self.step = max(1, step)
		
	func get_index() -> int:
		return idx
	
	func get_item():
		return array[idx]
		
	func should_continue():
		return idx < end
	
	func _iter_init(arg):
		idx = start
		return should_continue()
	
	func _iter_next(arg):
		idx += step
		return should_continue()
	
	func _iter_get(arg):
		return self
