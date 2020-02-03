#!/bin/bash
cd /home/container/scp_server

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

${MODIFIED_STARTUP}
