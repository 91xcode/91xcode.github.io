--设置GitHub仓库对应的本地resource目录
set resourcePath to "/usr/local/Cellar/nginx/1.19.1/html/typora_img/img/resource"

--获取要上传文件的路径
choose file with prompt "请选择要上传的文件"
set uploadfile to result
set uploadPath to POSIX path of (uploadfile) as string

--当前时间
set theDate to current date
set yearString to year of theDate as string
set monthNum to month of theDate as integer
if monthNum < 10 then
	set monthString to ("0" & (monthNum as string))
else
	set monthString to (monthNum as string)
end if

--获取当前时间（年-月）
set currentDatePath to (yearString & "-" & monthString)
--最后文件复制到的路径
set copyedPath to (resourcePath & "/" & currentDatePath & "/")

--执行终端命令
tell application "Terminal"
	set windowA to do script "mkdir -p " & copyedPath & " && cp " & uploadPath & " $_ " & "
" & "cd " & resourcePath & "
" & "git add ." & "
" & "git commit -m 'add resource' " & "
" & "git push origin master"
end tell

tell application "Finder"
	--获取文件名（会有后缀名的）
	set uploadFileName to (name of uploadfile)
end tell

set sourceUrl to ("https://testingcf.jsdelivr.net/gh/91xcode/typora_img/img/resource/" & currentDatePath & "/" & uploadFileName)
display dialog "上传成功后获取到的链接" default answer sourceUrl buttons {"复制", "关闭"} default button 1 with title "提示" with icon note

if button returned of result = "复制" then
	--复制到剪切板
	set the clipboard to (text returned of result) as string
end if