# MathUtils.gd
extends RefCounted # Para funciones de utilidad que no son nodos

static func clampf(value: float, min_val: float, max_val: float) -> float:
	return maxf(min_val, minf(value, max_val))

static func map_range(value: float, in_min: float, in_max: float, out_min: float, out_max: float) -> float:
	return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

# Añade cualquier otra función matemática que necesites repetidamente
