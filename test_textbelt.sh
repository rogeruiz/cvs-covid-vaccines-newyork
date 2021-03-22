#!/bin/bash

currentDirectory=$(dirname "${0}")

phoneNumber=$(cat ${currentDirectory}/phone-number.txt)
api_key=$(cat ${currentDirectory}/textbelt-api-key.txt)
linkToWebsite="https://www.cvs.com/immunizations/covid-19-vaccine?icid=cvs-home-hero1-link2-coronavirus-vaccine#acc_link_content_section_box_251541438_boxpar_accordion_910919113_2"


curl -X POST https://textbelt.com/text \
      --data-urlencode phone=${phoneNumber} \
      --data-urlencode message="This is a test of textbelt. Your alerts are working!" \
      -d key=${api_key}
