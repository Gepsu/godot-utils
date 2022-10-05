class_name Animate extends Resource

static func property(object: Object, property: NodePath, final_val, duration := 1.0, trans := Tween.TRANS_LINEAR) -> AnimationData:
	var anim_callable := func():
		var tween: Tween = object.create_tween()
		tween.tween_property(object, property, final_val, duration)
		tween.set_trans(trans)
	return AnimationData.new(anim_callable)

class AnimationData extends Resource:
	var anim_callable: Callable
	
	func _init(anim_callable: Callable) -> void:
		self.anim_callable = anim_callable
	
	func play() -> void:
		anim_callable.call()
	
	func on_signal(_signal: Signal) -> void:
		_signal.connect(anim_callable)

#static func scale(node, _signal: Signal, target_scale: Vector2, duration := 0.1, trans: int = Tween.TRANS_BOUNCE) -> void:
#	if not _is_valid(node): return
#
#	_signal.connect(func(): 
#		var tween: Tween = node.create_tween()
#		tween.tween_property(node, "scale", target_scale, duration)
#		tween.set_trans(trans)
#	)
