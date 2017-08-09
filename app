#!/bin/bash
#################
##     app     ##
#########################
## CLI app entry point ##
#########################
: '
 
  a. Connect config of the CLI app
  b. Connect necessary colors
  c. Connect project aliases алиасы проекта

  1. Show helf if 0 arguments
  2. Validation of 1-st argument
  3. Save operation name, move all arguments to the left by 1
  4. If $operation == "aliases", invokr aliases script
  5. If $operation == "up"
  6. If $operation == "down"
  7. If $operation == "update"
 
'
#########################################################################
func_wrapper_app () { 

  # a. Connect config of the CLI app
  . other/cli/config

  # b. Connect necessary colors
  . other/cli/colors  
  
  # c. Connect project aliases
  . other/cli/aliases

  # 1. Show helf if 0 arguments
  if [ $# == 0 ]; then 

    # 1.1. Invoke help without options
    . other/cli/help

    # 1.2. Return
    return

  fi

  # 2. Validation of 1-st argument
  # - It it is't empty, but acceptable
  if [ $1 != "aliases" ] && [ $1 != "install" ] && [ $1 != "up" ] && [ $1 != "down" ] && [ $1 != "update" ]; then 

    # 2.1. Notify about inadmissible value of 1-st agrument
    echo "--- app ---> Inadmissible value of the 1-st agrument"

    # 2.2. Return
    return

  fi

  # 3. Save operation name, move all arguments to the left by 1
  # - Operation name is in 1-st argument
  operation=$1
  shift 1

  # 4. If $operation == "aliases", invokr aliases script
  if [ $operation == "aliases" ]; then 

    # 4.1. Invoke arguments parsing
    OPTIND=1
    while getopts ":h" opt; do
      case $opt in
        h)  
          # Show help for aliases operation
          # . other/cli/help aliases  
          return
          ;;
        *) 
          # Do nothing
          return
          ;;
      esac
    done

    # 4.2. Invoke aliases script
    # . other/cli/aliases

    # 4.3. Return
    return    

  fi

  # 5. If $operation == "up"
  if [ $operation == "up" ]; then 

    # 5.1. Invoke arguments parsing
    OPTIND=1
    while getopts ":h" opt; do
      case $opt in
        h)  
          # Show help for up operation
          . other/cli/help up
          return
          ;;
      esac
    done

    # 5.2. Invoke up script
    . other/cli/up

    # 5.3. Return
    return    

  fi

  # 6. If $operation == "down"
  if [ $operation == "down" ]; then 

    # 6.1. Invoke arguments parsing
    OPTIND=1
    while getopts ":h" opt; do
      case $opt in
        h)  
          # Show help for down operation
          . other/cli/help down  
          ;;
        *) 
          # Do nothing
          ;;
      esac
    done

    # 6.2. Invoke down script
    . other/cli/down

    # 6.3. Return
    return    

  fi

  # 7. If $operation == "update"
  if [ $operation == "update" ]; then 

    # 7.1. Invoke arguments parsing
    OPTIND=1
    while getopts ":h" opt; do
      case $opt in
        h)  
          # Show help for update operation
          . other/cli/help update  
          ;;
        *) 
          # Do nothing
          ;;
      esac
    done

    # 7.2. Invoke update script
    . other/cli/update

    # 7.3. Return
    return    

  fi

:;}
func_wrapper_app "$@"






