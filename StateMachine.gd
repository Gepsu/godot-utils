class_name StateMachine extends Node

var _states: Dictionary
var _current_state: StateFunctions
var _state
var _stack: Array

func _init(parent: Node) -> void:
	parent.add_child(self)
	set_process_input(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	set_physics_process(false)
	set_process(false)

func add_state(state) -> StateFunctions:
	_states[state] = StateFunctions.new()
	return _states[state]

func change_state(state) -> void:
	if not _states.has(state) or _state == state:
		return
	
	# Exit call
	if _current_state and _current_state.exited.is_valid():
		_current_state.exited.call()
		
	_current_state = _states[state]
	
	# Enter call
	if _current_state.entered.is_valid():
		_current_state.entered.call()
		
	_current_state._toggle_functions(self)
	_state = state

func get_state():
	return _state

func _input(event: InputEvent) -> void:
	_current_state.input.call(event)

func _unhandled_input(event: InputEvent) -> void:
	_current_state.unhandled_input.call(event)

func _unhandled_key_input(event: InputEvent) -> void:
	_current_state.unhandled_key_input.call(event)

func _physics_process(delta: float) -> void:
	_current_state.physics_process.call(delta)

func _process(delta: float) -> void:
	_current_state.process.call(delta)

class StateFunctions:
	var input: Callable
	var unhandled_input: Callable
	var unhandled_key_input: Callable
	var physics_process: Callable
	var process: Callable
	var entered: Callable
	var exited: Callable
	
	# Disable unused functions
	func _toggle_functions(sm: StateMachine) -> void:
		sm.set_process_input(input.is_valid())
		sm.set_process_unhandled_input(unhandled_input.is_valid())
		sm.set_process_unhandled_key_input(unhandled_key_input.is_valid())
		sm.set_physics_process(physics_process.is_valid())
		sm.set_process(process.is_valid())
	
	func set_input(_input: Callable) -> StateFunctions:
		self.input = _input
		return self
	
	func set_unhandled_input(_unhandled_input: Callable) -> StateFunctions:
		self.unhandled_input = _unhandled_input
		return self
	
	func set_unhandled_key_input(_unhandled_key_input: Callable) -> StateFunctions:
		self.unhandled_key_input = _unhandled_key_input
		return self
	
	func set_physics_process(_physics_process: Callable) -> StateFunctions:
		self.physics_process = _physics_process
		return self
	
	func set_process(_process: Callable) -> StateFunctions:
		self.process = _process
		return self
	
	func set_entered(_entered: Callable) -> StateFunctions:
		self.entered = _entered
		return self
	
	func set_exited(_exited: Callable) -> StateFunctions:
		self.exited = _exited
		return self
