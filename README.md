### 📜 Godot Utils for Godot 4.0
A set of short and simple scripts and functions that vary from not useful at all to eh this will save me a line of code. If you have ideas for more feel free to let me know. I will update this as i go 🙂

**Contents**
- <a href=#animate>Animate</a>
- <a href=#areasound>Area Sound</a>
- <a href=#debuglabel>Debug Label</a>
- <a href=#prefab>Prefab</a>
- <a href=#soundmanager>Sound Manager</a>
- <a href=#pool>Object Pool</a>
- <a href=#statemachine>StateMachine</a>
- <a href=#utils>Utils</a>

---

🦾 <b id="animate"><a href="https://github.com/Gepsu/godot-utils/blob/master/Animate.gd">Animate.gd</a></b>  
Animate class for simple tween animations quickly and effortlessly. This allows you to tween properties either right on call or set it to be called via a signal. I will be making some wild premade animations and share them here some day in the future...

Usage:
- Call this to create the tween followed by either `.play()` or `.on_signal(Signal)`  
`Animate.property(object: Object, property: NodePath, final_val, duration := 1.0, trans := Tween.TRANS_LINEAR)`

Example:
```
# Adds a scale up/down tween to a button on mouse_entered and mouse_exited signal
func _ready() -> void:
	Animate.property($Button, "scale", Vector2.ONE * 1.1, 0.1, Tween.TRANS_BOUNCE).on_signal($Button.mouse_entered)
	Animate.property($Button, "scale", Vector2.ONE, 0.1, Tween.TRANS_BOUNCE).on_signal($Button.mouse_exited)
```

Presets:
- Scales between start and end value till stop signal is emitted  
`Animate.pulse_scale(object, start_val, end_val, stop_signal: Signal, duration := 1.0, trans := Tween.TRANS_SINE, ease := Tween.EASE_IN_OUT)`
- Rotates left and right by given degree till stop signal is emitted  
`Animate.swing(object, rotation_degrees: float, stop_signal: Signal, duration := 1.0, trans := Tween.TRANS_SINE, ease := Tween.EASE_IN_OUT)`
- Goes through all colors till stop signal is emitted  
`Animate.rainbow(object: CanvasItem, stop_signal: Signal, saturation := 1.0, duration := 1.0)`

<br>

🎵 <b id="areasound"><a href="https://github.com/Gepsu/godot-utils/blob/master/AreaSound.gd">AreaSound.gd</a></b>  
A sound class that plays sounds in certain areas of the game when a node that is being followed enters them

Usage:
- Add AreaSound node to your scene and draw the area you want with Polygon2D
- Assign followed node to something. This is usually either your player character or the camera.
- You can also change your follow node via code by setting `following_node` to a valid Node2D

<br>

✏️ <b id="debuglabel"><a href="https://github.com/Gepsu/godot-utils/blob/master/DebugLabel.gd">DebugLabel.gd</a></b>   
A simple label class that lists everything you want to see

Usage:
- Add Debug label to your UI scene
- Call `Debug.Print(String, variant1, variant2 = null, variant3 = null...)` (up to 7) from any script
- If your string includes '%' it assume you wanna use string formatting  
https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/gdscript_format_string.html
- F1 to toggle it on or off

<br>

📦 <b id="prefab"><a href="https://github.com/Gepsu/godot-utils/blob/master/Prefab.gd">Prefab.gd</a></b>  
A prefab class that takes existing sets of nodes in your scene and packs them into a neat little package that can be pasted later. Think copy paste but better

Usage:
- Create a prefab by calling `var prefab = Prefab.new(Node, free_original = false)`
- You can reparent it by calling `prefab.parent(new_parent)` or while you're pasting it
- Paste your prefab by calling `prefab.paste(new_parent = original_parent)`

<br>

🎵 <b id="soundmanager"><a href="https://github.com/Gepsu/godot-utils/blob/master/SoundManager.gd">SoundManager.gd</a></b>  
Yet another simple script for your sounds! Play music or sound effects

Usage:
- Should be used as a singleton
- Create a playlist and call  
`SoundManager.play_through(playlist: Array[AudioStream], play_order = PlayOrder.InOrder)`
- You can call `SoundManager.play_next()` to skip song altho this will be called automatically when the previous song ends
- For sound effects you can call either  
`SoundManager.play_sound(sound: AudioStream, volume = 1.0, pitch_shift := 0.0)`
- Or if you want it to be directional then use  
`SoundManager.play_directional_sound(sound: AudioStream, position: Vector2, volume = 1.0, pitch_shift := 0.0)`

<br>

🏊 <b id="pool"><a href="https://github.com/Gepsu/godot-utils/blob/master/ObjectPool.gd">ObjectPool.gd</a></b>  
A class that stores objects in it for later use, cutting out loading new objects (unless you want more than what's in there) and hopefully giving you a couple more frames. While they're in the pool, all the process functions are disabled

Usage:
- To begin you wanna create a new pool `var pool = Pool.new(parent: Node)`
- To add objects in the pool you call `pool.add_to_pool(key: String, scene: PackedScene, preload_objects = 1)`
- To get objects out of the pool you call `pool.get_next(key: String) -> Node`
- And to put objects back in the pool you call `pool.put_back(object: Node)`
- In case you wanna free every object in the pool you can call `pool.free_all()`

<br>

🤖 <b id="statemachine"><a href="https://github.com/Gepsu/godot-utils/blob/master/StateMachine.gd">StateMachine.gd</a></b>  
A simple helper class for switching states and running functions

Usage:
- You create your state machine by calling `var sm = StateMachine.new(self)` in the script you wanna use the state machine in
- You add different states to it by using the `sm.add_state(state: Variant)` function, followed by one of the these:
	- `.set_input(input_function: Callable)`
	- `.set_unhandled_input(unhandled_input_function: Callable)`
	- `.set_unhandled_key_input(unhandled_key_input_function: Callable)`
	- `.set_physics_process(physics_process_function: Callable)`
	- `.set_process(process_function: Callable)`
	- Note that these can be chained together one after the other `.set_input(blah).set_physics_process(bleh)...`
- The state machine will run these through the appropriate functions and come with both `delta` and `InputEvent`
- To change states you call `sm.change_state(state: Variant)`

Example:
```
func _ready() -> void:
	sm = StateMachine.new(self)
	sm.add_state(State.Ground).set_physics_process(ground).set_input(ground_input)
	sm.add_state(State.Air).set_physics_process(air)
	sm.add_state(State.HurtWall).set_physics_process(hurt_wall)
	sm.add_state(State.HurtAir).set_physics_process(hurt_air)
	sm.add_state(State.HurtGround).set_physics_process(hurt_ground)
	sm.change_state(State.Air)
	
func ground_input(event: InputEvent) -> void:
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func ground(delta: float) -> void:
	add_gravity(delta)
	...
```

<br>

🤷 <b id="utils"><a href="https://github.com/Gepsu/godot-utils/blob/master/Utils.gd">Utils.gd</a></b>  
A script full of simple and sometimes random static functions

Usage:
- Get file names in folder  
`Utils.get_files_in_folder(path, extension = "", full_path = false, starts_with = "", max_items = 999) -> Array`
- Create a 2D array  
`Utils.create_2d_array(width, height, default_value = null) -> Array`
- For rolling chances you give it a number between 0 and 1, if the random number is below the number you gave it returns true  
`Utils.chance(number) -> bool`
- Pick a random item in an array  
`Utils.array_random(Array) -> Variant`
- Check if the difference between numbers is below threshold  
`Utils.numbers_are_close(a, b, threshold) -> bool`
- Clamps a control node to viewport  
`Utils.clamp_to_viewport(viewport, control, margin = 0.0) -> void`
- Simple reconnect function for reconnecting (or just connecting) signals  
`Utils.reconnect(_signal: Signal, callable: Callable, flags := 0) -> void`
- Better pivot offset. Sets it according to the size. How much could be either a Vector2 or float  
`Utils.offset_pivot(control: Control, how_much = Vector2.ZERO) -> void`
- Get a random point in polygon  
`Utils.get_random_point_in_polygon(polygon: PackedVector2Array) -> Vector2`
- Iterates through the array returning an enumerable that contains the current item and index.  
Current item is stored in `i.item` and `i.current` variables as well as `i.get_item()`.  
Current index is stored in `i.idx` and `i.count` variables as well as `i.get_index()`.  
`for i in Utils.enumerate(array, start = 0, end = array.size(), step = 1)`
