extends Node
class_name Utils

## Returns file names in folder
static func get_files_in_folder(path: String, extension: String = "", full_path: bool = false, starts_with: String = "", max_items: int = 999) -> Array:
	var files = []
	var dir = Directory.new()
	dir.open(path)
	
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
static func make_2d_array(width: int, height: int, default_value = null) -> Array:
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
	control.global_position.x = clamp(control.global_position.x, margin, viewport.get_visible_rect().end.x - control.size.x * 2 - margin)
	control.global_position.y = clamp(control.global_position.y, margin, viewport.get_visible_rect().end.y - control.size.y * 2 - margin)
