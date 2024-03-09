#!/bin/bash 
#
# use for change /etc/hosts file 
# author          :zhaoming.xuezm
# date            :2011-12-5
# last modify     :2011-12-6
# version         :1.0.0


#------------------------------------------------------ param check  --------------------------------------------------
if [ $# -ne 1 ];then 
   echo 'Type 'hc help' for usage.'
   exit 1 
fi

#------------------------------------------------------ init --------------------------------------------------

#check has the privilege to change hosts 
user_name=`id -nu`
group_name=`id -ng`
if [ $group_name = "root" ];then 
  echo 'please input adminstrator passwd :'
  sudo gpasswd -a $user_name $group_name

fi


cd `dirname $0`
bin_path=`pwd`

# hostdir is used to store host file which add by operator 
if [ ! -d hostdir ];then
   mkdir hostdir 
fi
cd $bin_path/hostdir 

host_suffix="_host"
current_hostfile=""
action=$1

declare -a host_array;

#error_code  && error message 
none_files=4
none_files_message="you should add a file first !"

#------------------------------------------------------ list all host file --------------------------------------------------
list_host(){

  local index=1

  file_num=`ls *host >> /dev/null 2>&1`
  if [ $? -ne 0 ];then 
     printf "%s\n" "none files"
	 return $none_files
  else 
    for i in `ls *host`
        do
           #should cut the "_host"  suffix
           temp=$i 
		   real_length=`expr length $temp`
		   suffix_length=`expr length $host_suffix`
		   need_length=`expr $real_length - $suffix_length`
		   real_name=`expr substr $temp 1 $need_length`
	       echo "$index : $real_name"
		   
           
	       host_array[$index]=$i
	       index=$(($index+1))
        done

    fi
}

#judge parameter 1 is equal system default  
check_is_default_hostfile(){
  if [ $# -ne 1 ];then 
     echo 'param error ! '
	 return 2
  fi
  
  if [ -z $current_hostfile ] || [ $current_hostfile = $1 ];then 
    return 0
  fi
}

switch_host(){

  echo '------welcome to use host switch-------'
  list_host
  if [ $? -eq $none_files ];then
     echo "$none_files_message"
	 exit
  fi

  read selection 

  cat ${host_array[$selection]} > /etc/hosts
  current_hostfile=${host_array[$selection]}
  echo "------switch to " ${host_array[$selection]} "------"
}


add_host(){

  echo '------input file name ------'
  read filename
  vim $filename

  mv $filename $filename$host_suffix
}

del_host(){

  echo '------del host:choose the file  -----'
  list_host

  if [ $? -eq $none_files ];then
     echo "$none_files_message"
	 exit
  fi

  read selection 
  rm -f  ${host_array[$selection]}

  if [ $? -eq 0 ];then 
      echo "del host file ${host_array[$selection]} success"
  else 
      echo "del host file ${host_array[$selection]} failed"
  fi
}

edit_host(){
  echo '------eidt host:choose the file  -----'
  list_host

  if [ $? -eq $none_files ];then
     echo "$none_files_message"
	 exit
  fi

  read selection 
  vim   ${host_array[$selection]}
 
  check_is_default_hostfile ${host_array[$selection]}
  if [ $? -eq 0 ];then 
     cat ${host_array[$selection]} > /etc/hosts
  fi 
   
}

show_file_content(){

   list_host
   if [ $? -eq $none_files ];then
      echo "$none_files_message"
	  exit
   fi

   read selection 
   cat ${host_array[$selection]}

}
show_version(){
 printf "\n" 
 printf "%s\n" 'hc :host change , version 1.0.0 '
 printf "\n" 
 printf "%s\n"  "Copyright (C) 2011-2011 inter12."
 printf "\n" 
}

show_help(){
 printf "\n"
 printf "%s\n" "most subcommand take action ! If not allow  no arguments  supplied to such a command!"
 printf "\n"
 printf "%s\n" "Available subcommands:"
 printf "%s\n" "    add                 : add a new host file and saved as name which you input ! it locate in the path: path/hostdir  "
 printf "%s\n" "    del                 : del the host file ! if this file is current used as system hosts .will still valid ! "
 printf "%s\n" "    edit                : edit the host file  and if the file you edit is current syste, hosts ,it will take effect immediately !"
 printf "%s\n" "    sw                  : change the file which you choose as a system default hosts " 
 printf "%s\n" "    list                : list all host file !"
 printf "%s\n" "    version | --version : show hc version "
 printf "%s\n" "    help | --help       : show hc command format !"
 printf "\n"
 printf "\n"

 printf "%s\n" "hc is a tool for host change !"
 printf "%s\n" "For additional infomation. you can mail to godspeed712@gmail.com | zhaoming.xuezm@alibaba-inc.com"
}

#------------------------------------------------------ main entrance --------------------------------------------------
case "$action" in 
  sw)
     switch_host
  ;;
  add)
     add_host
  ;;
  del)
     del_host
  ;;
  edit)
     edit_host
  ;;
  list)
     show_file_content
  ;;
  --help | help)
     show_help
  ;;
  --version | version)
     show_version
  ;;
  *)
    echo 'Type 'hc help' for usage.'
  ;;

esac
