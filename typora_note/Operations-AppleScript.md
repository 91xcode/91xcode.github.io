# AppleScript

## 需求

>   macos一些批量操作利用AppleScript来实现
>   macos版本11.6.1 

## 步骤

### 1. typora批量导出为html.scpt

```javascript

set folderToProcess to (choose folder with prompt "Choose Folder::")

tell application "Finder"
	activate
	set fileExt to {".md"}
	set theTopFolder to (folderToProcess as alias)
	repeat with EachFile in (get every file of folder (folderToProcess as alias))
		
		try
			copy name of EachFile as string to FileName
			repeat with ext in fileExt
				if FileName ends with ext then
					-- set result to (open EachFile)
					open EachFile
					-- msg(result)
					
					tell application "System Events"
						tell process "Typora"
							--set frontmost to true
							delay 3
							click (menu item "HTML" of menu "导出" of menu item "导出" of menu "文件" of menu bar item "文件" of menu bar 1)
							delay 1
							click button "存储" of sheet 1 of window 1
							click button "替换" of sheet 1 of sheet 1 of window 1
							
						end tell
					end tell
					
					delay 3
					
				end if
			end repeat
			
		end try
		
		
	end repeat
	
	delay 2
	tell application "Typora"
		quit
	end tell
	
end tell
```

### 2. 将粘贴板内容自动写到备忘录中.scpt
```javascript

set noteHTMLText to "<pre style=\"font-family:Helvetica,sans-serif;\">" & ¬
	(the clipboard as Unicode text) & "</pre>"
tell application "Notes"
	activate
	set thisAccountName to my getNameOfTargetAccount("Choose an account:")
	display dialog "Enter the title for the new note:" default answer ¬
		"New Note" with icon 1 with title "New Note with Clipboard"
	set the noteTitle to the text returned of the result
	tell account thisAccountName
		make new note at folder "Notes" with properties {name:noteTitle, body:noteHTMLText}
	end tell
end tell

on getNameOfTargetAccount(thisPrompt)
	tell application "Notes"
		if the (count of accounts) is greater than 1 then
			set theseAccountNames to the name of every account
			set thisAccountName to ¬
				(choose from list theseAccountNames with prompt thisPrompt)
			if thisAccountName is false then error number -128
			set thisAccountName to thisAccountName as string
		else
			set thisAccountName to the name of account 1
		end if
		return thisAccountName
	end tell
end getNameOfTargetAccount

```

### 3. imessage.scpt
vim  imessage.scpt
```javascript

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

```


```shell
vim send.sh

#!/usr/bin/env bash
osascript ./imessage.scpt "$1" "$2"

```

执行

```javascript

./send.sh +40712344321 "Message body goes here"

or directly

osascript imessage.scpt +40712344321 "Message body goes here"
```