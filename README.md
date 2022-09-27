### 📜 Godot Utils for Godot 4.0
A set of short and simple scripts and functions that vary from not useful at all for some people to eh this will save me a line of code. If you have ideas for more feel free to let me know. I will update this as i go 🙂

**Contents**
- <a href=#areasound>Area Sound</a>
- <a href=#debuglabel>Debug Label</a>
- <a href=#prefab>Prefab</a>
- <a href=#soundmanager>Sound Manager</a>
- <a href=#utils>Utils</a>

---

🎵 <b id="areasound">AreaSound.gd</b>  
Plays sounds in certain areas of the game when a node that is being followed enters them

Usage:
- Add AreaSound node to your scene and draw the area you want with Polygon2D
- Call `AreaSound.set_following(Node2D)` to set your follow node. This is usually your player character

<br>

✏️ <b id="debuglabel">DebugLabel.gd</b>   
A simple label that lists everything you want to see

Usage:
- Add Debug label to your UI scene
- Call `Debug.print(String, variant1, variant2 = null, variant3 = null...)` (up to 7) from any script
- If your string includes '%' it assume you wanna use string formatting  
https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html

<br>

📦 <b id="prefab">Prefab.gd</b>  
Prefab script that takes existing sets of nodes in your scene and packs them into a neat little package that can be pasted later. Think copy paste

Usage:
- Create a prefab by calling `Prefab.new(Node, free_original = false)`
- You can reparent it by calling `prefab.parent(new_parent)` or while you're pasting it
- Paste your prefab by calling `prefab.paste(new_parent = original_parent)`

<br>

🎵 <b id="soundmanager">SoundManager.gd</b>  
Yet another simple script for your sounds! Play music or sound effects

Usage:
- Can be used as a singleton
- Create a playlist and call `SoundManager.play_through(playlist: Array, play_order = PlayOrder.InOrder)`
- You can call `SoundManager.play_next()` to skip song altho this will be called automatically when the previous song ends
- For sound effects you can call either `SoundManager.play_sound(sound: AudioStream, volume = 1.0)` or if you want it to be directional then use `SoundManager.play_directional_sound(sound: AudioStream, position: Vector2, volume = 1.0)`

<br>

🤷 <b id="utils">Utils.gd</b>  
A script full of simple static functions

Usage:
- Get file names in folder  
`Utils.get_files_in_folder(path, extension = "", full_path = false, starts_with = "", max_items = 999) -> Array`
- Create a 2D array  
`Utils.make_2d_array(width, height, default_value = null) -> Array`
- For rolling chances you give it a number between 0 and 1, if the number is below that number it returns true  
`Utils.chance(number) -> bool`
- Picks a random item in an array  
`Utils.array_random(Array) -> Variant`
- Check if the difference between numbers is below threshold  
`Utils.numbers_are_close(a, b, threshold) -> bool`
- Clamps a control node to viewport  
`Utils.clamp_to_viewport(viewport, control, margin = 0.0) -> void`
