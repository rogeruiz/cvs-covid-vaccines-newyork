#!/bin/bash

currentDirectory=$(dirname "${0}")

api_key=$(cat ${currentDirectory}/textbelt-api-key.txt)

curl https://textbelt.com/quota/${api_key}
