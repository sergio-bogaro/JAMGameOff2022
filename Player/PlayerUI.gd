extends CanvasLayer

onready var healthLabel = $PlayerStatusContainer/HealthContainer/HealthPoints
onready var manaLabel = $PlayerStatusContainer/ManaContainer/ManaPoints

func ManaChanged(newMP):
	manaLabel.text = str(newMP)

func HealthChanged(newHP):
	healthLabel.text = str(newHP)
