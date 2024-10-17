#!/bin/bash

sum=0
# Loop through the numbers between 1000 and 2000
for number in {1000..2000}; do
    # Check if the number consists of only digits 0 and 1
    if [[ $number =~ ^[01]+$ ]]; then
        # Add the number to the sum if it matches the condition
        sum=$(($sum + $number))
    fi
done
# Output the result
echo "The sum of numbers between 1000 and 2000 with digits {0, 1} is: $sum"
