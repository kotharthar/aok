# README

# All OK (aok)

All OK (aok) is a simple script to run the OpenAI API CHAT completions command. It can be used to generate text completions from a given input text. It takes user input via command line or STDIN and generates AI response with GPT-3 API. The chatbot keeps a history of 4 messages and can generate creative or definite answers based on user input. 

## Installation

All OK (aok) requires Python 3 and pip3 to be installed.

Run the following command to install the OpenAI CLI:

```bash
pip install --upgrade openai
```

Get your API Key from [OpenAI](https://openai.com/) and `OPENAI_API_KEY` in your environment variables:

```bash
export OPENAI_API_KEY="xxx"
```

## Usage

All OK (aok) can be used in three different ways:

1. CHAT mode:

```bash
$ aok chat
```

2. With an input text string:

```bash
$ aok "And the input text string like this"
```

3. With an input text file:

```bash
$ echo "And the input text string like this" | aok
$ cat input.txt | aok
```

## Featured Instructions

The application is using OpenAI Chat completion API with `gpt-3.5-turbo` engine.
The System Prompt is designed to be sensitive to specific keywards in the user input and produce conscise yet different responses. The following keywords are used to generate different responses:

1. `Command for`, `Command to` and `How to` are used to generate a command code example and explanation.
2. `What is` and `Explain` are used to generate a definition and explanation.
3. `Code example` and `Sample code` are used to generate a code example in specified lanaguage and explanation.
4. `Steps` or `step by step` are used to generate a numbered list of step by step guide.
5. `Summary` or `Summarize` are used to generate a summary of the input text or code.
6. If there is no specific instruction in input, it will summarize the input text or code.

## Add Alias

Add the following line to your .bashrc or .zshrc file to add an alias for aok:

```
alias "??"='path/to/aok.sh'
```

## License

All OK (aok) is licensed under the MIT License.