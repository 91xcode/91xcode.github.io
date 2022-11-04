on run {targetBuddyPhone, targetMessage}
    set myArray to my theSplit(targetMessage, "|")
	count of myArray
	set num to count of myArray

	if num = 0 then
		set ret to "fail"
	else if num = 1 then
		set input_text to item 1 of myArray
		tell application "Messages"
			set myid to get id of first service
			set theBuddy to buddy targetBuddyPhone of service id myid
			send input_text to theBuddy
			
		end tell
		set ret to "Ok from imput_text"
	else if num = 2 then
		set input_text to item 1 of myArray
		set input_file to item 2 of myArray
		set theAttachment1 to POSIX file input_file
		tell application "Messages"
			set myid to get id of first service
			set theBuddy to buddy targetBuddyPhone of service id myid
			send input_text to theBuddy
			send theAttachment1 to theBuddy
			
		end tell
		set ret to "Ok from imput_file"
	end if
end run

on theSplit(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end theSplit
