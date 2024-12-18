#!/bin/bash

# List of server names and IPs
declare -A servers
servers=(
    ["Cisco switch 602"]="10.129.86.2"
    ["602 Printer"]="10.129.86.3"
    ["Sonicwall Analyzer"]="10.129.86.4"
    ["FreestoneNG1 Wifi Router"]="10.129.86.5"
    ["602 Camera"]="10.129.86.6"
    ["FreestoneNG-5G Wifi"]="10.129.86.7"
    ["Bio Metric 602"]="10.129.86.8"
    ["502 FreestoneUB-5G Wifi"]="10.129.86.9"
    ["502 Camera"]="10.129.86.10"
    ["Bio Mertic 502"]="10.129.86.11"
    ["Cisco switch 502"]="10.129.86.12"
    ["California Server"]="10.129.86.116"
    ["Paris Server"]="10.129.86.117"
    ["New York Server"]="10.129.86.118"
    ["Mumbai Server"]="10.129.86.184"
    ["Singapore Server"]="10.129.86.194"
    ["Bio Metric Server"]="10.129.86.196"
)

# Explicitly define the desired order of server names
ordered_servers=(
    "Cisco switch 602"
    "602 Printer"
    "Sonicwall Analyzer"
    "FreestoneNG1 Wifi Router"
    "602 Camera"
    "FreestoneNG-5G Wifi"
    "Bio Metric 602"
    "502 FreestoneUB-5G Wifi"
    "502 Camera"
    "Bio Mertic 502"
    "Cisco switch 502"
    "California Server"
    "Paris Server"
    "New York Server"
    "Mumbai Server"
    "Singapore Server"
    "Bio Metric Server"
)

# File to store the results
output_file="ping_results.txt"

# Clear the output file
> $output_file

# Header for the output
echo "==========================" | tee -a $output_file
echo "     Ping Test Results     " | tee -a $output_file
echo "==========================" | tee -a $output_file
printf "%-5s %-25s %-15s %-15s\n" "No." "Server Name" "IP Address" "Status" | tee -a $output_file
echo "-----------------------------------------------------------" | tee -a $output_file

# Initialize counter
counter=1

# Loop through the ordered list of servers
for name in "${ordered_servers[@]}"; do
    ip="${servers[$name]}"
    printf "%-5s %-25s %-15s" "$counter" "$name" "$ip" | tee -a $output_file
    
    # Ping the server (5 packets) and check if it's reachable
    if ping -c 5 "$ip" > /dev/null 2>&1; then
        printf "%-15s\n" "Reachable" | tee -a $output_file
    else
        printf "%-15s\n" "Not Reachable" | tee -a $output_file
    fi
    
    # Increment the counter
    counter=$((counter + 1))
done

# Footer for the output
echo "-----------------------------------------------------------" | tee -a $output_file
echo "Ping test results are attached below." | mailx -s "Ping Test Results" -A $output_file hiten.wala@freestoneinfotech.com
