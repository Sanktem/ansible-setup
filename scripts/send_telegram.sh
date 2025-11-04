#!/bin/bash

# Set the API token and chad ID
TOKEN=$(<telegram_token.txt) #telegram_token.txt
CHAT_ID=$(<chat_id.txt) #chat_id.txt

# Set the message Text
MESSAGE=$1 #the message

curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null
