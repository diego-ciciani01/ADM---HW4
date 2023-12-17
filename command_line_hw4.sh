
#FIRST QUESTIONS 
# -F',' sets the field separator to comma
# '{print $4}' prints the fourth column of each line in the CSV file
# Pipes the output to the sort command to sort the values
# Uses uniq to count the occurrences of each unique value and -c option to display the count
# Sorts the counts in descending order using the -nr option
# Displays only the first line, which corresponds to the most frequent value with its count
awk -F',' '{print $4}' vodclickstream_uk_movies_03.csv | sort | uniq -c | sort -nr | head -n 1



#SECOND QUESTIONS
# Filter lines where the value in the third column is greater than or equal to 0.0
awk -F ',' '{ if ($3 >= 0.0) print $0 }' vodclickstream_uk_movies_03.csv > filtered_duration.csv

# Calculate the average duration from the third column in the filtered file
avg_duration=$(awk -F ',' '{print $3}' filtered_duration.csv | awk '{sum += $1} END {print sum/NR}')

# Convert the average duration from seconds to minutes with two decimal places
avg_min=$(awk -v avg_duration="$avg_duration" 'BEGIN { avg_min = avg_duration / 60; printf "%.2f\n", avg_min }')

# Display the average duration in minutes
echo "Average duration of subsequent clicks: $avg_min minutes"

#THIRD QUESTIONS

# Use AWK to process a tab-separated file (FS='\t')
# '{sum[$1]+=$4}' - For each unique value in the first column, accumulate the sum of values in the fourth column
# END{} - Executed after processing all lines in the file
# {for (i in sum) print i, sum[i]} - Print each unique value in the first column along with its corresponding sum

awk -F'\t' '{sum[$1]+=$4} END{for (i in sum) print i, sum[i]}' vodclickstream_uk_movies_03.csv |

# Use sort to order the output based on the second column (sum) in numeric, reverse order
sort -k2,2nr |

# Use head to display only the first line of the sorted output
head -n1

