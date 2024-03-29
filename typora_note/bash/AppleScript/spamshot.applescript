-- iMessage Spam报告自动化脚本 spamshot by ashfinal

(*
	使用方法:
	如果你需要扫描举报已有的垃圾信息(数量较多)，请通过脚本编辑器直接运行该脚本(快捷键为⌘+R)。

	如果想每当接收到垃圾信息时自动弹窗举报，请按照以下设置：
	1. 打开Messages设置-General-AppleScript handler，下拉框选择"Open Scripts Folder";
	2. 把该脚本扔到打开的Finder窗口，再到刚才的Messages设置里选择该脚本;
	3. 到控制面板－隐私与安全－Privacy－Accessibility里面点加号手动添加iMessages.app的辅助控制权限;

	以上配置完成后，你可以对想要举报的iMessage回复"spam report"或者"垃圾举报"即可实现自动化举报。Y(^_^)Y
*)

-- weibo: @敢和蜗牛赛跑
-- Email: ashfinal@sina.cn
-- 2014.12.22

property blacklist : {"http", "赌场", "注册", "博彩", "抢购", "会员", "纽巴伦"} -- 设置关键词，效果与max_count值有关
property max_count : 2 -- 出现多少个以上关键词判定为spam(需保证为正数)
property watchdog_switch : true -- 切换是否主动监控(值为false时就是所谓的免打扰模式，不抢占工作窗口焦点)
property del_further : true -- 删除该信息会话？若为回复举报模式则需手动确认一下
property send_now : false -- 立即发送邮件？除非测试，否则建议设置为true

using terms from application "Messages"
	on message received theMessage from theBuddy for theChat
		if watchdog_switch = true then
			if check_msg(theMessage) = true then
				try
					stay_top()
					set sender_name to the name of theBuddy
					set receive_time to updated of theChat
					display dialog "发现来自 " & sender_name & "的疑似垃圾信息：" & return & theMessage & return & return & "想要举报它为垃圾信息吗？" buttons {"Cancel", "OK"} default button 1 with title "发现有情况" with icon note giving up after 5
					if button returned of the result = "OK" then
						set sender_history to read_history(sender_name)
						if sender_history = {} then
							stay_top()
							tell application "Messages"
								show chat chooser for theBuddy
							end tell
							msgpic_shot(theBuddy)
							send_mail(sender_name, receive_time)
							set picPath to (POSIX path of (path to desktop)) & "spamshot.png"
							do shell script "rm " & picPath
							set report_log to sender_name & " | " & (current date)
							write_log(report_log)
							if del_further = true then delete theChat
						else
							set how_many to item 1 of sender_history
							set lasttime_reported to item 2 of sender_history
							display dialog "你已经举报过 " & sender_name & " 该账户 " & how_many & " 次了，" & return & "最后一次举报时间 " & lasttime_reported & return & return & "你想要再次举报吗？" buttons {"Cancel", "OK"} default button 1 with title "之前已举报过" with icon stop giving up after 5
							if button returned of the result = "OK" then
								stay_top()
								tell application "Messages"
									show chat chooser for theBuddy
								end tell
								msgpic_shot(theBuddy)
								send_mail(sender_name, receive_time)
								set picPath to (POSIX path of (path to desktop)) & "spamshot.png"
								do shell script "rm " & picPath
								set report_log to sender_name & " | " & (current date)
								write_log(report_log)
								if del_further = true then delete theChat
							end if
						end if
					end if
				on error eText number eNum
					if eNum = -25211 then
						display dialog "你需要确认信息 Messages.app 已开启辅助访问控制。" & return & "路径为控制面板－隐私与安全－Privacy－Accessibility." buttons {"OK"} default button 1 with icon stop giving up after 5
					else
						if eNum ≠ -128 then display dialog "Some other error: " & eNum & return & eText buttons {"OK"} default button 1 with icon stop giving up after 5
					end if
				end try
			end if
		end if
	end message received
	
	on message sent theMessage for theChat
		if theMessage is in {"spam report", "垃圾举报"} then
			set text_type to service type of service of theChat as text
			if text_type = "iMessage" then
				set chat_buddies to participants of theChat
				set spamer to item 1 of chat_buddies
				set sender_name to the name of spamer
				set receive_time to updated of theChat
				try
					display dialog "想要举报来自 " & sender_name & " 的该条信息为垃圾iMessage？" buttons {"Cancel", "OK"} default button 2 with title "Report as spam?" with icon note giving up after 5
					if button returned of the result = "OK" then
						set sender_history to read_history(sender_name)
						if sender_history = {} then
							stay_top()
							msgpic_shot(spamer)
							send_mail(sender_name, receive_time)
							set picPath to (POSIX path of (path to desktop)) & "spamshot.png"
							do shell script "rm " & picPath
							set report_log to sender_name & " | " & (current date)
							write_log(report_log)
							tell application "System Events"
								set frontmost of process "Messages" to true
							end tell
						else
							set how_many to item 1 of sender_history
							set lasttime_reported to item 2 of sender_history
							display dialog "你已经举报过 " & sender_name & " 该账户 " & how_many & " 次了，" & return & "最后一次举报时间 " & lasttime_reported & return & return & "你想要再次举报吗？" buttons {"Cancel", "OK"} default button 1 with title "之前已举报过" with icon stop giving up after 5
							if button returned of the result = "OK" then
								stay_top()
								msgpic_shot(spamer)
								send_mail(sender_name, receive_time)
								set picPath to (POSIX path of (path to desktop)) & "spamshot.png"
								do shell script "rm " & picPath
								set report_log to sender_name & " | " & (current date)
								write_log(report_log)
								tell application "System Events"
									set frontmost of process "Messages" to true
								end tell
							end if
						end if
					end if
				on error eText number eNum
					if eNum = -25211 then
						display dialog "你需要先确认信息 Messages.app 已开启辅助访问控制。" & return & "路径为控制面板－隐私与安全－Privacy-Accessibility." buttons {"OK"} default button 1 with icon stop giving up after 5
					else
						if eNum ≠ -128 then display dialog "Some other error: " & eNum & return & eText buttons {"OK"} default button 1 giving up after 5
					end if
				end try
			end if
		end if
	end message sent
	
	on addressed message received theMessage from theBuddy for theChat
		
	end addressed message received
	
	on chat room message received theMessage from theBuddy for theChat
		
	end chat room message received
	
	on active chat message received theMessage
		
	end active chat message received
	
	on addressed chat room message received theMessage from theBuddy for theChat
		
	end addressed chat room message received
	
	# The following are unused but need to be defined to avoid an error
	
	on received text invitation theText from theBuddy for theChat
		
	end received text invitation
	
	on received audio invitation theText from theBuddy for theChat
		
	end received audio invitation
	
	on received video invitation theText from theBuddy for theChat
		
	end received video invitation
	
	on received remote screen sharing invitation from theBuddy for theChat
		
	end received remote screen sharing invitation
	
	on received local screen sharing invitation from theBuddy for theChat
		
	end received local screen sharing invitation
	
	on received file transfer invitation theFileTransfer
		
	end received file transfer invitation
	
	on buddy authorization requested theRequest
		
	end buddy authorization requested
	
	on av chat started
		
	end av chat started
	
	on av chat ended
		
	end av chat ended
	
	on login finished for theService
		
	end login finished
	
	on logout finished for theService
		
	end logout finished
	
	on buddy became available theBuddy
		
	end buddy became available
	
	on buddy became unavailable theBuddy
		
	end buddy became unavailable
	
	on completed file transfer
		
	end completed file transfer
	
end using terms from

activate application "Messages"
tell application "Messages"
	set all_texts to every text chat
	set imsg_set to {}
	repeat with i in all_texts
		set text_type to service type of service of i as text
		if text_type = "iMessage" then
			copy i to the end of imsg_set
		end if
	end repeat
	
	set keyword_count to 0
	set spam_pool to {}
	
	repeat with j in imsg_set
		set imsg_content to the subject of j as Unicode text
		repeat with kw in blacklist
			if imsg_content contains kw then
				set keyword_count to keyword_count + 1
				if keyword_count ≥ max_count then
					copy j to the end of spam_pool
				end if
			end if
		end repeat
	end repeat
	
	set spam_count to count of spam_pool
	set spamer_set to {}
	set spamer_list to {}
	repeat with k in spam_pool
		set chat_buddies to participants of k
		set spamer to item 1 of chat_buddies
		set spamer_name to the name of spamer
		if spamer_set does not contain spamer_name then
			copy spamer_name to the end of spamer_set
			copy spamer to the end of spamer_list
		end if
	end repeat
	
	set spamer_count to count of spamer_set
	if spamer_count > 0 then
		try
			display dialog "发现来自 " & spamer_count & " 个账户的 " & spam_count & " 条疑似垃圾信息" & return & return & "你想要现在查看它们吗？" buttons {"Cancel", "OK"} default button 2 with title "发现疑似信息" with icon note
			if button returned of the result = "OK" then
				repeat with l in spamer_list
					set sender_name to the name of l
					set receive_time to (updated of text chats whose participants contains l)
					set spam_content to (the subject of text chats whose participants contains l) as Unicode text
					--	if length of spam_content ≥ 50 then set spam_content to words 1 through 50 of spam_content
					display dialog "☆ 信息发送者: " & sender_name & return & "☆ 接收时间: " & receive_time & return & return & spam_content & return & return & "你想要举报它为垃圾信息吗？" buttons {"Cancel", "OK"} default button 2 with title "总共需要 " & spamer_count & " 次垃圾信息确认"
					if button returned of the result = "OK" then
						set sender_history to read_history(sender_name) of me
						if sender_history = {} then
							stay_top() of me
							tell application "Messages"
								show chat chooser for l
							end tell
							msgpic_shot(l) of me
							send_mail(sender_name, receive_time) of me
							set todel_chat to (every text chat whose participants contains l)
							if del_further = true then delete todel_chat
						else
							set how_many to item 1 of sender_history
							set lasttime_reported to item 2 of sender_history
							display dialog "你已经举报过 " & sender_name & " 该账户 " & how_many & " 次了，" & return & "最后一次举报时间 " & lasttime_reported & return & return & "你想要再次举报吗？" buttons {"Cancel", "OK"} default button 1 with title "之前已举报过" with icon stop
							if button returned of the result = "OK" then
								stay_top() of me
								tell application "Messages"
									show chat chooser for l
								end tell
								msgpic_shot(l) of me
								send_mail(sender_name, receive_time) of me
								set todel_chat to (every text chat whose participants contains l)
								if del_further = true then delete todel_chat
							end if
						end if
					end if
				end repeat
			end if
			activate application "Messages"
			display dialog "Job's Done! Y(^_^)Y" buttons {"OK"} default button 1 with icon note
		on error eText number eNum
			if eNum = -25211 then
				display dialog "你需要确认脚本编辑器 Script Editor.app 已开启辅助访问控制。" & return & "路径为控制面板－隐私与安全－Privacy－Accessibility." buttons {"OK"} default button 1 with icon stop giving up after 5
			else
				if eNum ≠ -128 then display dialog "Some other error: " & eNum & return & eText buttons {"OK"} default button 1 giving up after 5
			end if
		end try
	else
		if spamer_count = 0 then display dialog "恭喜！没有发现垃圾信息 (☆_☆)" buttons {"OK"} default button 1 with icon note
	end if
end tell

on check_msg(msg_content)
	set item_count to 0
	repeat with kw in blacklist
		if msg_content contains kw then set item_count to item_count + 1
	end repeat
	if item_count ≥ max_count then
		return true
	else
		return false
	end if
end check_msg


on stay_top()
	tell application "System Events"
		set frontmost of process "Messages" to true
		tell process "Messages"
			if windows = {} then
				click menu item 9 of menu 1 of menu bar item 7 of menu bar 1
			else
				if (count of windows) > 1 then
					if the name of window 1 is not in {"Messages", "信息"} then
						click menu item 9 of menu 1 of menu bar item 7 of menu bar 1
					end if
				else
					if the subrole of window 1 = "AXDialog" then
						click menu item 9 of menu 1 of menu bar item 7 of menu bar 1
					end if
				end if
			end if
		end tell
	end tell
end stay_top

on msgpic_shot(spam_buddy)
	tell application "System Events"
		tell process "Messages"
			set area2_pos to the position of scroll area 2 of splitter group 1 of window 1
			set area2_size to the size of scroll area 2 of splitter group 1 of window 1
			set win_pos to the position of window 1
			set win_size to the size of window 1
			set fixed_xPos to item 1 of area2_pos as string
			set fixed_yPos to item 2 of win_pos as string
			set fixed_width to item 1 of area2_size as string
			set fixed_height to item 2 of win_size as string
			set capt_var to fixed_xPos & "," & fixed_yPos & "," & fixed_width & "," & fixed_height
		end tell
	end tell
	
	set picPath to (POSIX path of (path to desktop)) & "spamshot.png"
	do shell script "screencapture -T1 -R" & capt_var & " " & picPath
	
	tell application "System Events"
		tell process "Messages"
			click menu item 9 of menu 1 of menu bar item 3 of menu bar 1
		end tell
	end tell
end msgpic_shot

on send_mail(spam_id, up_time)
	activate application "Mail"
	-- 发送Email给苹果公司。当然，你自己的默认邮箱账户需要先配置好。
	tell application "Mail"
		set mailContent to "Dear Sir/Madam," & return & return & "Recently I've got more and more iMessage spam in my inbox, which is really annoying. So I use this tiny script just to make reporting abuse more convenient. Please consider to block the Apple ID below, Thank you." & return & return & "Apple ID: " & spam_id & return & "Received Time: " & up_time & return & return
		set newCompose to make new outgoing message with properties {visible:true, subject:"iMessage Spam Report", content:mailContent}
		tell newCompose
			make new to recipient with properties {name:"Apple Spam Report", address:"imessage.spam@icloud.com"}
		end tell
		set picPath to (POSIX path of (path to desktop)) & "spamshot.png"
		set theAttachment to picPath
		tell content of newCompose
			make new attachment with properties {file name:theAttachment} at after last paragraph
		end tell
		if send_now = true then send newCompose
	end tell
end send_mail

on write_log(content)
	set event_log to ((path to home folder) as text) & "spamshot_log.txt"
	try
		open for access file the event_log with write permission
		write (content & return) to file the event_log starting at eof
		close access file the event_log
	on error
		try
			close access file the event_log
		end try
	end try
end write_log

on read_history(for_whom)
	set event_log to ((path to home folder) as text) & "spamshot_log.txt"
	set reported_pool to {}
	set reptime_pool to {}
	try
		set fp to open for access file the event_log
		set log_content to ""
		if (get eof fp) ≠ 0 then
			set log_content to read fp using delimiter return
			set AppleScript's text item delimiters to " | "
			repeat with m in log_content
				set temp_addr to text item 1 of m
				set temp_time to text item 2 of m
				copy temp_addr to the end of reported_pool
				copy temp_time to the end of reptime_pool
			end repeat
		end if
		close access fp
	on error
		try
			close access file the event_log
		end try
	end try
	
	set times_value to 0
	set temp_num_refer to 0
	set query_index to 0
	repeat with n in reported_pool
		set temp_num_refer to temp_num_refer + 1
		if n as text = for_whom then
			set times_value to times_value + 1
			set query_index to temp_num_refer
		end if
	end repeat
	
	set query_result to {}
	if times_value ≥ 1 then
		set lastest_when to item query_index of reptime_pool
		copy times_value to the end of query_result
		copy lastest_when to the end of query_result
	end if
	
	return query_result
end read_history
