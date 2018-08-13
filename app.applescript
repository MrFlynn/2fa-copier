-- Run shell script and store result as `response`.
do shell script (["bash ~/Desktop/2fa-copier/message.sh"] as text)
set response to result

if response is not "-1" then
	-- Display auth code if the response isn't -1
	display dialog "Would you like to copy auth code: " & response & �
		" to the Clipboard?" buttons {"Copy", "Cancel"} �
		default button �
		"Copy" cancel button �
		"Cancel" with title �
		"New Authentication Code Found" with icon �
		note giving up after 10
	
	-- Copy auth code to the clipboard if the user confirms.
	if button returned of result = "Copy" then
		set the clipboard to response
	end if
end if