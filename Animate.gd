class_name Animate extends Resource

static func _is_valid(node) -> bool:
	if not (node is Node2D or node is Control):
		printerr("Animate node has to be Node2D or Control")
		return false
	return true

static func scale(node, _signal: Signal, target_scale: Vector2, duration := 0.1, trans: int = Tween.TRANS_BOUNCE) -> void:
	if not _is_valid(node): return
	
	_signal.connect(func(): 
		var tween: Tween = node.create_tween()
		tween.tween_property(node, "scale", target_scale, duration)
		tween.set_trans(trans)
	)
