### 📜 Godot Utils for Godot 4.0
A set of short and simple scripts and functions that vary from not useful at all to eh this will save me a line of code. If you have ideas for more feel free to let me know. I will update this as i go 🙂

**Contents**
- <a href=#areasound>Area Sound</a>
- <a href=#debuglabel>Debug Label</a>
- <a href=#prefab>Prefab</a>
- <a href=#soundmanager>Sound Manager</a>
- <a href=#pool>Object Pool</a>
- <a href=#statemachine>StateMachine</a>
- <a href=#utils>Utils</a>

---

🎵 <b id="areasound"><a href="https://github.com/Gepsu/godot-utils/blob/master/AreaSound.gd">AreaSound.gd</a></b>  
A sound class that plays sounds in certain areas of the game when a node that is being followed enters them

Usage:
- Add AreaSound node to your scene and draw the area you want with Polygon2D
- Call `AreaSound.set_following(Node2D)` to set your follow node. This is usually your player character

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
- Create a playlist and call `SoundManager.play_through(playlist: Array, play_order = PlayOrder.InOrder)`
- You can call `SoundManager.play_next()` to skip song altho this will be called automatically when the previous song ends
- For sound effects you can call either `SoundManager.play_sound(sound: AudioStream, volume = 1.0)` or if you want it to be directional then use `SoundManager.play_directional_sound(sound: AudioStream, position: Vector2, volume = 1.0)`

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
- Here's an example image of the state machine in action
![image](https://user-images.githubusercontent.com/28844450/192623238-a6266427-e931-41be-8269-5406fc91894a.png)

<br>

🤷 <b id="utils"><a href="https://github.com/Gepsu/godot-utils/blob/master/Utils.gd">Utils.gd</a></b>  
A script full of simple static functions

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
- Get a random point in polygon  
`Utils.get_random_point_in_polygon(polygon: PackedVector2Array) -> Vector2`
