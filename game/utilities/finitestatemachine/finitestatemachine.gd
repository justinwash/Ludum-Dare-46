extends Node

export(NodePath) var ACTOR
export(NodePath) var START_STATE

var states

var current_state = null
var actor = null

func _ready():
	states = {
		"init": $Init
	}
	actor = get_node(ACTOR)

	current_state = get_node(START_STATE)
	if current_state.has_method("ready"):
		current_state.ready(actor)
	current_state.enter(actor)

func _physics_process(_delta):
	current_state.update(actor)

func change_state(state_name):
	current_state.exit()
	current_state = states[state_name]
	if current_state.has_method("ready"):
		current_state.ready(actor)
	current_state.enter(actor)
