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
  db_return="$(sqlite3 -line ~/Library/Messages/chat.db < chat.sql)"

  # Remove the 'text = ' prefix from the beginning of the db return value.
  IFS=$"=" read -ra message <<< "$db_return"
  message=("${message[@]:1}")

  echo "${message[@]}"
}

#######################################
# Extracts auth code from text message.
# Globals:
#   None
# Arguments:
#   message_contents: full contents of
#   text message with auth code.
# Returns:
#   Auth code from text message.
#######################################
get_auth_code () {
  # Function arguments
  local message_contents="$1"

  # Store list of potential codes.
  local codes=()
  local auth_code=""

  # Extract all potential codes from message.
  IFS=$" " read -ra words <<< "$message_contents"
  for word in "${words[@]}"; do
    codes+=("${word//[^0-9]/}")
  done

  # Auth code is likely to be the longest number in the array.
  for code in "${codes[@]}"; do
    if [[ "${#code}" -ge "${#auth_code}" ]]; then
      auth_code=$code
    fi
  done

  echo "$auth_code"
}

#######################################
# Main function for program.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   Authentication code from most
#   recent text message or -1 for no
#   auth code found.
#######################################
main () {
  message_content="$(get_last_message)"

  if [[ "$message_content" = *"code"* ]]; then
    get_auth_code "$message_content"
  else
    echo -1
  fi
}

# Script entrypoint.
main "$@"
