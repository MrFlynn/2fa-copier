#!/bin/bash

#######################################
# Get the most recent message from 
# iMessage and outputs the text
# contents of said Message.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   String of text containing text
#   content of last message.
#######################################
get_last_message () {
  # Get the last message's content.
  db_return=$(sqlite3 -line ~/Library/Messages/chat.db < chat.sql)

  # Remove the 'text = ' prefix from the beginning of the db return value.
  IFS=$"=" read -ra message <<< "$db_return"
  message=("${message[@]:1}")

  echo "${message[@]}"
}
