class_name Debug extends Label

const Registered = {}

@export var show_fps := true

func _unhandled_key_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_F1) and not event.is_echo():
		visible = !visible
		set_process(visible)

static func Print(what: String, v1, v2 = null, v3 = null, v4 = null, v5 = null, v6 = null, v7 = null) -> void:
	Registered[what] = [v1, v2, v3, v4, v5, v6, v7].filter(func(x): return x != null)

func _physics_process(_delta: float) -> void:
	if show_fps:
		Debug.Print("FPS: %s", Engine.get_frames_per_second())
	
	text = ""
	for key in Registered:
		if not "%" in key:
			text += key + ", ".join(Registered[key]) + "\n"
		else:
			text += key % Registered[key] + "\n"
