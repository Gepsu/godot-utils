class_name Animate extends Resource

static func property(object, property, final_val, duration := 1.0, trans := Tween.TRANS_LINEAR, ease := Tween.EASE_IN_OUT) -> AnimationData:
	var anim_callable := func():
		var tween: Tween = object.create_tween()
		tween.tween_property(object, property, final_val, duration)
		tween.set_trans(trans)
	return AnimationData.new(anim_callable)

static func custom(anim: Callable) -> AnimationData:
	return AnimationData.new(anim)

static func pulse_scale(object, start_val, end_val, stop_signal: Signal, duration := 1.0, trans := Tween.TRANS_SINE, ease := Tween.EASE_IN_OUT) -> AnimationData:
	var anim_callable := func():
		var tween: Tween = object.create_tween()
		tween.tween_property(object, "scale", end_val, duration)
		tween.tween_property(object, "scale", start_val, duration)
		tween.set_loops(0)
		tween.set_trans(trans)
		stop_signal.connect(tween.kill)
	return AnimationData.new(anim_callable)

static func swing(object, rotation_degrees: float, stop_signal: Signal, duration := 1.0, trans := Tween.TRANS_SINE, ease := Tween.EASE_IN_OUT) -> AnimationData:
	var anim_callable := func():
		var tween: Tween = object.create_tween()
		tween.tween_property(object, "rotation", deg_to_rad(-abs(rotation_degrees)), duration / 2)
		tween.set_trans(trans)
		tween.tween_callback(func():
			tween = object.create_tween()
			tween.tween_property(object, "rotation", deg_to_rad(abs(rotation_degrees)), duration)
			tween.tween_property(object, "rotation", deg_to_rad(-abs(rotation_degrees)), duration)
			tween.set_loops(0)
			tween.set_trans(trans)
			stop_signal.connect(tween.kill)
		)
		stop_signal.connect(tween.kill)
	return AnimationData.new(anim_callable)

static func rainbow(object: CanvasItem, stop_signal: Signal, saturation := 1.0, duration := 1.0) -> AnimationData:
	var anim_callable := func():
		var tween: Tween = object.create_tween()
		tween.tween_property(object, "modulate:h", 0, 0)
		tween.tween_property(object, "modulate:s", saturation, 0.1)
		tween.tween_property(object, "modulate:h", 1, duration)
		tween.set_loops(0)
		stop_signal.connect(tween.kill)
	return AnimationData.new(anim_callable)

class AnimationData extends Resource:
	var anim_callable: Callable
	
	func _init(anim_callable: Callable) -> void:
		self.anim_callable = anim_callable
	
	func play() -> void:
		anim_callable.call()
	
	func on_signal(_signal: Signal) -> void:
		_signal.connect(anim_callable)
