#!/bin/bash

set -e -o pipefail

areAnyAvailable="false"

currentDirectory=$(dirname "${0}")

phoneNumber=$(cat ${currentDirectory}/phone-number.txt)
api_key=$(cat ${currentDirectory}/textbelt-api-key.txt)
linkToWebsite="https://www.cvs.com/immunizations/covid-19-vaccine?icid=cvs-home-hero1-link2-coronavirus-vaccine#acc_link_content_section_box_251541438_boxpar_accordion_910919113_2"

rm -rf ${currentDirectory}/cvs-output.json

curl \
  -s \
  $(cat ${currentDirectory}/api-endpoint.txt) \
  -H "$(cat ${currentDirectory}/header-user-agent.txt)" \
  -H 'Accept: */*' \
  -H 'Accept-Language: es-MX,es;q=0.8,en-US;q=0.5,en;q=0.3' \
  --compressed \
  -H  "$(cat ${currentDirectory}/header-referer.txt)"\
  -H 'Connection: keep-alive' \
  -H "$(cat ${currentDirectory}/cookie-data.txt)" \
  -H 'TE: Trailers' > ${currentDirectory}/cvs-output.json

cat ${currentDirectory}/towns.txt | while read t
do

  areAnyAvailable=$(
    jq --arg t "${t}" \
      -r \
      '.responsePayloadData.data.NY[] | select(.city == $t) | .status == "Available"' \
      -- ${currentDirectory}/cvs-output.json
  )

  if [[ "${areAnyAvailable}" == 'true' ]]
  then
    echo "Yes vaccines available at "${t}" CVS! $(date)"
    curl -X POST https://textbelt.com/text \
      --data-urlencode phone=${phoneNumber} \
      --data-urlencode message="There are vaccines available at "${t}" CVS! $(date) ${linkToWebsite}" \
      -d key=${api_key}
    echo
  else
    echo "No vaccines available at "${t}" CVS. $(date)"
  fi

done
