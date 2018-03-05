#!/bin/bash

COLOR=${MONIT_COLOR:-$([[ $MONIT_EVENT == *"succeeded"* ]] && echo good || echo danger)}
TEXT=$(echo "$MONIT_EVENT: $MONIT_DESCRIPTION" | python3 -c "import json,sys;print(json.dumps(sys.stdin.read()))")

PAYLOAD="{
  \"attachments\": [
    {
      \"text\": $TEXT,
      \"color\": \"$COLOR\",
      \"mrkdwn_in\": [\"text\"],
      \"fields\": [
        { \"title\": \"Date\", \"value\": \"$MONIT_DATE\", \"short\": true },
        { \"title\": \"Host\", \"value\": \"$MONIT_HOST\", \"short\": true },
        { \"title\": \"Source\", \"value\": \"monit\", \"short\": true}
      ]
    }
  ]
}"

curl -s -X POST -H "application/json" -d "payload=$PAYLOAD" {{ slack_webhook_url }}
