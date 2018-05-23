#/bin/bash

# Count the number of failed logins by an attacker
# If there are IP's with over the limit failure, notification would be generated
# In the notification, display the count, IP and location of the IP from wheere it attack originated

# Create a sample variable which can be changed later
LIMIT='10'

# Give the log file to be used from the command line
LOG_FILE="${1}"

# Incorporate a check in case the file was supplied or not using loop
if [[ ! -e "${LOG_FILE}" ]]
then
    echo "Cannot open the log file: ${LOG_FILE}" >&2
    exit 1
fi

# Loop through a list of failed attempts and corrsponding IP Addresses from the file
grep Failed "${LOG_FILE}" | awk '{print $(NF -3)}' | sort | uniq -c | sort -nr | while read COUNT IP
do
    
    # If number of failed attempts is greater than the limit, then display the count, IP and location using geolocation command
    if [[ "${COUNT}" -gt "${IP}"]]
    then
        LOCATION=$(geolookup ${IP} | awk ', ' '{print $2}')
        echo "${COUNT},${IP},${LOCATION}"
    fi
done
exit 0