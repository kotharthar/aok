#!/usr/bin/env python
import openai
import os
from colorama import init, Fore, Style, Back

# OpenAI Parameters
openai.api_key = os.environ["OPENAI_API_KEY"] # replace with your API key

# Max number of token to generate.  # Keep it brief for commandline chat case.
max_tokens = 256

# Max number of chat history to feed back. If this number is too large, it will cost more input Tokens
max_history_size = 4

# Initial framing system prompot
system_prompt = {"role": "system", "content":'You are smart command-line assistance. GIVE ONE ANSWER with a specific example command for questions start with "command for/to" or "how to", and explain in 3 bullets  LESS THAN 40 WORDS. For with "what is" or "explain", give one sentence definitive answer LESS THAN 20 WORDS, follow by a paragraph UPTO 75 WORDS.'}

# keep_history function keeps only the last 4 messages
# in history by keeping first in first out approach.
history = []
def keep_history(message):
  if len(history) > 4:
      history.pop(0)
  history.append(message)

print("All " + chr(0x1F44C) + " !")
while True:
  user_input = input("\n" + Fore.BLUE + "ME: " + Style.RESET_ALL)

  # If user_input is bye or exit exit the loop
  if user_input in ["bye", "exit"]:
    print(Back.GREEN + Fore.RED + "AI:" + Style.RESET_ALL + " All" + print(chr(0x1F44C))
    break

  # Prepare the input message
  user_message = {"role": "user", "content": user_input}

  # Call to API REF: https://platform.openai.com/docs/api-reference/chat/create
  response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo", # this is fixed for this ChatCompletion call
    max_tokens=max_tokens, # number of tokens to generate
    n=1,                   #  number of completions to generate
    temperature=0.1,       # Keep it close to zero for definite answer
    messages=([system_prompt] + history + [user_message]),
  )
  
  ai_message = response.choices[0].message # The reponse message from AI
  content = ai_message["content"]          #  The content of the AI's reponse message
  keep_history(user_message)      # Keep the last user message in history
  keep_history(ai_message)        # Keep the last AI message in history
  print(Back.GREEN + Fore.RED + "AI:" + Style.RESET_ALL, content)
  print('-' * 40)  