#!/bin/bash

# Check if a folder was passed as an argument
if [ $# -eq 0 ]; then
  echo "Error: No folder specified"
  exit 1
fi

# Change to the specified folder
cd "$1"

# Create the variables
N_bdp=(0.5 5 10 20 30 40 50)
n_flows=50
trials=1

# Initialize the CSV file
echo "N_bdp,flow,trial,bits_per_second" > cubic_results.csv

# Loop over N_bdp, n_flows, and trials
for i in "${N_bdp[@]}"; do
  for j in $(seq 0 "$((n_flows))"); do
    for k in $(seq 1 "$trials"); do
      # Read the file into a variable
      cubic_data=$(<"cubic-result-$i-$j-$k.json")

      # Extract the value from the JSON
      value=$(echo "$cubic_data" | jq -r '.end.sum_received.bits_per_second')

      # Append the values to the CSV file
      echo "$i,$j,$k,$value" >> cubic_results.csv
    done
  done
done
