#!/bin/bash                                                                                                                                                                                                                                        

# Ensure the correct file is used                                                                                                                                                                                                                  
FILE="Property_Tax_Roll.csv"

# Check if the file exists                                                                                                                                                                                                                         
if [[ ! -f "$FILE" ]]; then
    echo "File $FILE does not exist. Please make sure it has been downloaded."
    exit 1
fi

# Process the data and calculate the average                                                                                                                                                                                                       
average=$(cat "$FILE" | \
    grep "MADISON SCHOOLS" | \
    cut -d',' -f7 | \
    awk '                                                                                                                                                                                                                                          
    BEGIN { sum=0; count=0 }                                                                                                                                                                                                                       
    {                                                                                                                                                                                                                                              
        # Remove possible quotes and convert to numeric                                                                                                                                                                                            
        gsub(/"/, "", $1)                                                                                                                                                                                                                          
        sum += $1                                                                                                                                                                                                                                  
        count += 1                                                                                                                                                                                                                                 
    }                                                                                                                                                                                                                                              
    END {                                                                                                                                                                                                                                          
        if (count > 0)                                                                                                                                                                                                                             
            print sum / count                                                                                                                                                                                                                      
        else                                                                                                                                                                                                                                       
            print "No matching data found."                                                                                                                                                                                                        
    }                                                                                                                                                                                                                                              
    ')

# Output the result                                                                                                                                                                                                                                
echo "The average TotalAssessedValue for MADISON SCHOOLS district is: $average"
