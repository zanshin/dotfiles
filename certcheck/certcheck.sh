#!/bin/bash

set -e
set -o pipefail

###
# certcheck displays the good from and good until dates for SSL certificates.
# It expects a file (.certs) that contains a list of domains to query. Each
# entry in the file has two parts, the name to display, and the domain to
# query. The two entries are separated by a space.
###

echo -e "certcheck\n"

filename=".certs"
while read -r line; do
    # Parse input into an array, using space as delimiter
    certarray=($line)

    # Get the name and the domain
    name=${certarray[0]}
    domain=${certarray[1]}

    # Get the certificate start and end dates
    result=$(echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -dates)

    # Muck with internal field separator (IFS) to split $result on new line
    oldIFS=$IFS
    IFS=$'\n'
    datearray=($result)
    IFS=$oldIFS

    startdate=${datearray[0]}
    enddate=${datearray[1]}

    # Print the results in columns
    printf "%-15s %-30s %-30s\n" "$name" "$startdate" "$enddate"
done < "$filename"

echo -e "\nfinished"
