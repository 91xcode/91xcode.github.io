#!/usr/bin/env bash


# pandoc -v 看到 pandoc data目录：/Users/xx/.local/share/pandoc. 将css文件复制过来 
# 然后在此目录写md文件 然后sh convert-markdown-to-html-css-with-pandoc.sh 
# done


# Usage: bannerSimple "my title" "*"
function bannerSimple() {
    local msg="${2} ${1} ${2}"
    local edge=$(echo "${msg}" | sed "s/./"${2}"/g")
    echo "${edge}"
    echo "$(tput bold)${msg}$(tput sgr0)"
    echo "${edge}"
    echo
}

# Usage: bannerColor "my title" "red" "*"
function bannerColor() {
    case ${2} in
    black)
        color=0
        ;;
    red)
        color=1
        ;;
    green)
        color=2
        ;;
    yellow)
        color=3
        ;;
    blue)
        color=4
        ;;
    magenta)
        color=5
        ;;
    cyan)
        color=6
        ;;
    white)
        color=7
        ;;
    *)
        echo "color is not set"
        exit 1
        ;;
    esac

    local msg="${3} ${1} ${3}"
    local edge=$(echo "${msg}" | sed "s/./${3}/g")
    tput setaf ${color}
    tput bold
    echo "${edge}"
    echo "${msg}"
    echo "${edge}"
    tput sgr 0
    echo
}



work_name=$(cd $(dirname $0); pwd)

filename="newsprint.css"

file_path=${work_name}/${filename} 

num=$(cat ${file_path}| grep -c "<style")

bannerColor "num:$num" "green" "*"
if [ $num -eq '1' ];then
	bannerColor "The File Has Add <style type='text/css'>xxx</style>!" "green" "*"

else
	gsed '1i <style type="text/css">' ${file_path} > ${file_path}_old && gsed '$a </style>' ${file_path}_old > ${file_path}

	bannerColor "add style tag done!" "green" "*"



fi

bannerColor "convert-markdown-to-html-css-with-pandoc strt!" "green" "*"

# pandoc -s -H ${file_path}  医保政策.md -o 医保政策.html

 
#============ get the file name ===========  
Folder_A=$(cd $(dirname $0); pwd)
for file_a in ${Folder_A}/*
do  
	if [ "${file_a##*.}" = "md" ]; then
            temp_file=`basename $file_a`  
    		# echo $temp_file 

			# echo ${Folder_A}/${temp_file}
    		# echo ${file_a%.*}

    		pandoc -s -H ${file_path}  ${Folder_A}/${temp_file}  -o ${file_a%.*}.html
    fi
 
done


bannerColor "convert-markdown-to-html-css-with-pandoc done!" "green" "*"


