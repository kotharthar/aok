#!/usr/bin/env python
import openai
import os

# OpenAI Parameters
openai.api_key = os.environ["OPENAI_API_KEY"] # replace with your API key

# Max number of token to generate.
# Keep it brief for commandline chat case.
max_tokens = 256

# Max number of chat history to feed back.
# If this number is too large, it will cost more input Tokens
max_history_size = 4

system_prompt = {"role": "system", "content":'You are smart command-line assistance. GIVE ONE ANSWER with a specific command example for question starts with "command for/to" or "how to", and explanation in 3 bullet points NOT MORE THAN 40 WORDS. For question starts with "what is", you give one sentence definitive answer LESS THAN 20 WORDS, follow by a paragraph UPTO 75 WORDS.'}

history = []

# keep_history function keeps only the last 4 messages
# in history by keeping first in first out approach.
def keep_history(message):
  if len(history) > 4:
      history.pop(0)
  history.append(message)

while True:
  user_input = input("User: ")

  # If user_input is bye or exit exit the loop
  if user_input in ["bye", "exit"]:
    print("AI: All OK ;)")
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

  print("AI:",content)