set prev to "0"

repeat
	-- Run shell script and store result as `response`.
	do shell script (["bash message.sh"] as text)
	set response to result
	
	if response is not "-1" then
		-- Display auth code if the response isn't -1
		if response is not prev then
			-- Only display dialog if the response is not the previous code.
      set prev to response

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
	end if
	
	-- Only run every 5 seconds.
	delay 5
end repeat
