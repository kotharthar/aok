# README

# All OK (aok)

All OK (aok) is a simple script to run the OpenAI API CHAT completions command. It can be used to generate text completions from a given input text. It takes user input via command line or STDIN and generates AI response with GPT-3 API. The chatbot keeps a history of 4 messages and can generate creative or definite answers based on user input. 

## Installation

All OK (aok) requires Python 3 and pip3 to be installed.

Run the following command to install the OpenAI CLI:

```
pip install --upgrade openai
```

Get your API Key from [OpenAI](https://openai.com/) andt OPENAI_API_KEY in your environment variables:

```
export OPENAI_API_KEY="xxx"
```

## Usage

All OK (aok) can be used in three different ways:

1. CHAT mode:

```
aok chat
```

2. With an input text string:

```
aok "And the input text string like this"
```

3. With an input text file:

```
echo "And the input text string like this" | aok
```

## Add Alias

Add the following line to your .bashrc or .zshrc file to add an alias for aok:

```
alias "??"='path/to/aok.sh'
```

## License

All OK (aok) is licensed under the MIT License.