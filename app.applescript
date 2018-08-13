-- Run shell script and store result as `response`.
do shell script (["bash ~/Desktop/2fa-copier/message.sh"] as text)
set response to result

if response is not "-1" then
	-- Display auth code if the response isn't -1
	display dialog "Would you like to copy auth code: " & response & Â
		" to the Clipboard?" buttons {"Copy", "Cancel"} Â
		default button Â
		"Copy" cancel button Â
		"Cancel" with title Â
		"New Authentication Code Found" with icon Â
		note giving up after 10
	
	-- Copy auth code to the clipboard if the user confirms.
	if button returned of result = "Copy" then
		set the clipboard to response
	end if
end if