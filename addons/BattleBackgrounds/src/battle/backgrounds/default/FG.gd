extends TextureRect

func _ready() -> void:
# warning-ignore:return_value_discarded
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))

func _on_viewport_size_changed() -> void:
	material.set_shader_parameter("screen_height", get_viewport().size.y)
