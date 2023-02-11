#!/bin/bash

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
  echo "       aok [input_text]"
  echo "       aok < input_file"
  echo ""
  echo "Options:"
  echo "  repl     Run the script in REPL mode, where you can enter input text interactively"
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
  # REPL mode
  while true; do
    read -p "Me: " input_text
    if [ -z "$input_text" ]; then
      break
    fi
    if [ "$input_text" == "bye" ]; then
      break
    fi
    echo -n "Davinci: "
    output_text=$(openai api completions.create --stream -m text-davinci-003 -M 500 -t 0.2 -p "$input_text")
    echo -n "$output_text"
    echo ""
    echo ""
  done
else
  # Get input text from either the command line argument or from a pipe
  if [ $# -eq 0 ]; then
    input_text=$(cat)
  else
    input_text="$@"
  fi

  # Run the OpenAI API completions command with input text
  openai api completions.create --stream -m text-davinci-003 -M 500 -t 0.2 -p "$input_text"
fi
