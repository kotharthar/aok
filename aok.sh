#!/bin/bash

# OpenAI Options
model="text-davinci-003"
max_tokens=500
temperature=0.2

# This script runs the OpenAI API completions command

# Check if the openai binary is in the PATH
if ! command -v openai > /dev/null; then
  echo "Error: openai binary not found in PATH"
  echo "Install python3 and pip3 first."
  echo "Run 'pip install --upgrade openai' to install the OpenAI CLI"
  echo "Reference: https://github.com/openai/openai-python"
  exit 1
fi

# Print the help message if the -h or --help option is provided
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  echo "All OK (aok) - A simple script to run the OpenAI API completions command"
  echo "Usage: aok repl"
  echo "       aok repl -remember"
  echo "       aok [input_text]"
  echo "       aok < input_file"
  echo ""
  echo "Options:"
  echo "  repl     Run the script in REPL mode, where you can enter input text interactively"
  echo "  -remember   Additional options for the repl mode to remember the previous input text and add it to the current input text"
  echo "  input_text   Input text to be aokd by the OpenAI API"
  echo ""
  echo "Examples:"
  echo "  aok repl"
  echo "  aok \"And the input text string like this\""
  echo "  echo \"And the input text string like this\" | aok"
  exit 0
fi

# Check if the first argument is "repl"
if [ "$1" == "repl" ]; then
  if [ "$2" == "-remember" ]; then
    echo "All OK! (Remembering mode)"
    echo ""
    remember=true
  else
    echo "All OK!"
    echo ""
    remember=false
  fi


  # REPL mode
  previous_input=""
  while true; do
    read -p "Me: " input_text
    if [ -z "$input_text" ]; then
      break
    fi
    if [ "$input_text" == "bye" ]; then
      break
    fi
    if [ "$remember" = true ]; then
      previous_input="$previous_input $input_text"

      # Remove the prefix and suffix extra spaces from the input_text
      input_text=$(echo "$previous_input" | sed 's/^ *//;s/ *$//' | sed 's/\?/\./g')
    else
      input_text=$(echo "$input_text" | sed 's/^ *//;s/ *$//' | sed 's/\?/\./g')
    fi

    num_tokens=$(echo "$input_text" | wc -w)
    echo -n "($num_tokens) AI: "
    output_text=$(openai api completions.create --stream -m $model -M $max_tokens -t $temperature -p "$input_text")

    # Remove the input_text from the output_text and display
    echo "$output_text" | awk -v text="$input_text" '{gsub(text, "")};1' |  tr -d '\n\n'
    echo ""
    echo ""

    # Added up the previous input text
    if [ "$remember" = true ]; then
        previous_input=$(echo $output_text | tr -d '\n')
    fi
  done
else
  # Get input text from either the command line argument or from a pipe
  if [ $# -eq 0 ]; then
    input_text=$(cat)
  else
    input_text="$@"
  fi

  # Run the OpenAI API completions command with input text
  openai api completions.create --stream -m $model -M $max_tokens -t $temperature -p "$input_text"
fi
