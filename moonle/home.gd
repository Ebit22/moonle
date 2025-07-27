extends Control

var crater_data = []
var goal = null
var input = 0
var guesses = []

func _ready():
	var file = FileAccess.open("res://craters100.json", FileAccess.READ)
	crater_data = JSON.parse_string(file.get_as_text())
	goal = crater_data[randi() % crater_data.size()]
	print(goal["Name"])
	$Button.disabled = false

func guess(input: String):
	for crater in crater_data:
		if crater["Name"].to_lower() == input.strip_edges().to_lower():
			var distance = (bereken_afstand(crater, goal))-(((goal["Diameter"]+.0)/2)+(crater["Diameter"]/2))
			guesses.append(crater["Name"])
			show_feedback(crater["Name"], distance)

func bereken_afstand(k1, k2):
	var lat1 = deg_to_rad(k1["Latitude"])
	var lon1 = deg_to_rad(k1["Longitude"])
	var lat2 = deg_to_rad(k2["Latitude"])
	var lon2 = deg_to_rad(k2["Longitude"])
	var dlat = lat2 - lat1
	var dlon = lon2 - lon1
	var a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
	var c = 2 * atan2(sqrt(a), sqrt(1-a))
	var radius = 1737.4 
	return round(radius * c)

func show_feedback(name, dist):
	if dist > 0:
		$FeedbackLabel.text = str(name) + " is " + str(dist) + "km from the mystery crater!"
	elif dist < 0:
		if dist == -1*goal["Diameter"]:
			$FeedbackLabel.text = "The mystery crater is " + str(name) + "!!!"
			$Button.disabled = true
			$"../../pop-up".show()
			print(guesses)
		elif dist < -1*goal["Diameter"]:
			$FeedbackLabel.text = str(name) + " is in the mystery crater!"
		else:
			$FeedbackLabel.text = str(name) + " is half in the mystery crater!"


func _on_button_pressed() -> void:
	input = $MarginContainer/LineEdit.text
	$MarginContainer/LineEdit.text = ""
	guess(input)

func _process(delta: float) -> void:
	pass


func _on_h_slider_changed(value: float) -> void:
	Gb.value = value/100



func _on_again_pressed() -> void:
	goal = crater_data[randi() % crater_data.size()]
	print(goal["Name"])
	$Button.disabled = false
	$FeedbackLabel.text = ""
	$"../../pop-up".hide()
	guesses = []
