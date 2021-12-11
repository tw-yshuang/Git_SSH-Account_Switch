#!/user/bin/env bash

function git-acc(){
  local function Echo_Color(){
    case $1 in
      r* | R* )
      COLOR='\e[31m'
      ;;
      g* | G* )
      COLOR='\e[32m'
      ;;
      y* | Y* )
      COLOR='\e[33m'
      ;;
      b* | B* )
      COLOR='\e[34m'
      ;;
      *)
      echo "$COLOR Wrong COLOR keyword!\e[0m" 
      ;;
    esac
    echo -e "$COLOR$2\e[0m"
  }

  local function Ask_yn(){
      printf "\e[33m$1\e[0m\e[33m [y/n] \e[0m"
      read respond
      if [ "$respond" = "y" -o "$respond" = "Y" ]; then
          return 1
      elif [ "$respond" = "n" -o "$respond" = "N" ]; then
          return 0
      else
          Echo_Color r 'wrong command!!'
          Ask_yn $1
          return $?
      fi
      unset respond
  }

  local function show_script_help(){
      local help='
            +---------------+
            |    git-acc    |
            +---------------+

    SYNOPSIS

      git-acc [account]/[-h]

    OPTIONS

      [account]               use which account on this shell, type account name that you register.
      -h, --help              print help information.
      -add, --add_account     build git_account info. & ssh-key.
      -rm, --remove_account   remove git_account info. & ssh-key from this device


    EXAMPLES

      $ git-acc.sh -a default
    '
    echo $help
  }

  local function _acc(){
    local users_info=$(cat "$gituser_locate" | grep -n '\[.*\]')
    accs_line=($(echo $users_info | cut -f1 -d ':'))
    accnames=($(echo $users_info | cut -d '[' -f2 | cut -d ']' -f1))
    unset users_info
  }

  # eval `ssh-agent`
  # ssh-add "~/.ssh/id_rsa_$acc_name"
  local ssh_key_locate="./id_rsa_" #"$HOME/.ssh/id_rsa_"
  local gituser_locate="./.gituser" #"~/.gituser"
  local GIT_ACC_ARG=()
  local GIT_ACC=()    # git account to 
  local user_name
  local user_mail
  local accs_line=()  # all the user's tag line that is in the $gituser_locate
  local accnames=()   # all the accnames that is in the $gituser_locate
  local overWrite=0   # is recover old ssh-key
  local acc_info=()   # single account info
  if [ "$#" -gt 0 ]; then
    while [ "$#" -gt 0 ]; do
      case "$1" in
        # Help
        '-h'|'--help')
          show_script_help
          unset -f show_script_help
          return 1
        ;;
        '-a'|'--account')
          GIT_ACC_ARG+='acc'
          shift 1
        ;;
        # build git_account info. & ssh-key.
        '-add'|'--add_account')
          GIT_ACC_ARG+='add'
          shift 1
        ;;
        # remove git_account info. & ssh-key from this device
        '-rm'|'--remove_account')
          GIT_ACC_ARG+='rm'
          shift 1
        ;;
        # use which account to access.
        * )
          GIT_ACC+=$1
          shift 1
        ;;
      esac
    done
  fi

  
  if [ "${#GIT_ACC_ARG[*]}" -gt 1 ] || [ "${#GIT_ACC_ARG[*]}" -ge 1 -a "${#GIT_ACC[*]}" -ge 1 ]; then
    Echo_Color r 'Wrong: Mutiple Parameters!!\n' # too many input args or accounts 
    return
  else
    case "${GIT_ACC_ARG[*]}" in
      'add')
        printf "Enter your git user name: "; read user_name
        printf "Enter your git user mail: "; read user_mail

        _acc # read accounts info.
        for acc_name in ${accnames[*]}; do
          if [ "$acc_name" = "$user_name" ]; then # if is not the match account_name
            Echo_Color r "Warning: Already have same account name."
            Ask_yn "Do you want to overwrite?" ; overWrite=$?
            if [ $overWrite = 0 ]; then
              Echo_Color y "Please use another account name."
              return
            fi
          fi
        done

        # generate ssh-key
        ssh-keygen -t rsa -C "$user_mail" -f "$ssh_key_locate$user_name"
        if [ $overWrite = 0 ]; then # if recover is not happen, then write it to the $gituser_locate, else nothing change.
          echo "[$user_name]\n\tname = $user_name\n\temail = $user_mail\n\tprivate_key = $ssh_key_locate$user_name\n\tpublic_key = $ssh_key_locate$user_name.pub" >> "$gituser_locate"
        fi
        source ./.
      ;;
      'rm')
        printf "Enter the git user name you want to remove: "; read user_name
        
        _acc # read accounts info.
        local i=1 # index of users array
        for acc_name in ${accnames[*]}; do
          if [ "$acc_name" != "$user_name" ]; then # if is not the match account_name
            i=$(( $i + 1))

            if [ "$i" -gt "${#accs_line[*]}" ]; then # if there isn't a match account_name 
              Echo_Color r "Wrong: account name!!"
              return
            fi
          else
            if [ "$i" = "${#accs_line[*]}" ]; then # is the last account in $gituser_locate
              acc_info=($(sed -n "${accs_line[$i]}, $ p" $gituser_locate | cut -f2 -d"="))
              sed -i "${accs_line[$i]}, $ d" $gituser_locate
            else
              acc_info=($(sed -n "${accs_line[$i]}, $((${accs_line[$(($i + 1))]} - 1)) p" $gituser_locate | cut -f2 -d"="))
              sed -i "${accs_line[$i]}, $((${accs_line[$(($i + 1))]} - 1)) d" $gituser_locate
            fi
              rm -rf "${acc_info[-2]}" "${acc_info[-1]}" # remove ssh private & publish keys
              source ./.
          fi
        done
      ;;
    esac
  fi

  if [ "${#GIT_ACC[*]}" -gt 1 ]; then
    Echo_Color r 'Wrong: Mutiple Parameters!!\n' # too many input args or accounts 
  elif [ "${#GIT_ACC[*]}" = 1 ]; then
    _acc # read accounts info.
    local i=1 # index of users array
    for acc_name in ${accnames[*]}; do
      if [ "$acc_name" != "$user_name" ]; then # if is not the match account_name
        i=$(( $i + 1))

        if [ "$i" -gt "${#accs_line[*]}" ]; then # if there isn't a match account_name 
          Echo_Color r "Wrong: account name!!"
          return
        fi
      else
        if [ "$i" = "${#accs_line[*]}" ]; then # is the last account in $gituser_locate
          acc_info=($(sed -n "${accs_line[$i]}, $ p" $gituser_locate | cut -f2 -d"="))
        else
          acc_info=($(sed -n "${accs_line[$i]}, $((${accs_line[$(($i + 1))]} - 1)) p" $gituser_locate | cut -f2 -d"="))
        fi
          eval `ssh-agent`
          ssh-add "${accs_line[-2]}" 
      fi
    done
  fi

  unset -f Echo_Color Ask_yn _acc
  unset -v GIT_ACC_ARG GIT_ACC user_name user_mail users_info cut_accs_line cut_username overWrite acc_info
}

local function _git-acc(){
  local function _acc(){
    local users_info=$(cat ./.gituser | grep -n '\[.*\]')
    local accs_line=$(echo $users_info | cut -f1 -d ':')
    local accnames=$(echo $users_info | cut -d '[' -f2 | cut -d ']' -f1) 
    echo "${accnames[*]}" | tr ' ' '\n'
    # unset users_info accs_line accnames
  }

  if [ "${#COMP_WORDS[*]}" -gt 3 ]; then
    return
  fi

  echo ${COMP_WORDS[*]}
  _acc; unset _acc
}

complete -W "$(_git-acc)" git-acc