extends Control

var validDecryptionKey = "basements, right?"
var validText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean eu porttitor orci, et vehicula dui. Quisque pharetra vulputate ipsum vel lacinia. Cras elementum metus ut placerat vulputate. Ut nec orci eleifend, posuere est et, luctus magna. Donec at rhoncus risus, id tincidunt ex. Morbi in justo elit. Aliquam."

var decryptionKey = ""
var textToDecrypt = ""

func decrypt() -> void:
	decryptionKey = $LineEdit.text
	textToDecrypt = $TextEdit.text
	
	if decryptionKey == validDecryptionKey and textToDecrypt == validText:
		$PopupPanel.popup()
