# Collect Palti data into one file including the file name, marker name and cM position

# set environment variables
OUTPUT_FILE="palti_etal_map.csv"

# move to the data folder
cd ./02_raw_data/01_collecting_from_websites/palti_etal_separated_sheets/

rm $OUTPUT_FILE 2> /dev/null 

# Save only the marker and cM position for each linkage group 
for i in $(ls -1 Omy*)
        do grep -v '^,' $i | 
        grep -vE 'There|Current' - |
        awk -F, '{print $1 "," $4 }' > "$i"_marker_and_cM.csv
     done

# collect the data from all of the separated sheets
for i in $(ls -1 *_marker_and_cM*) 
do 
    cat $i | \
        while read line
        do
            echo ${i}","${line} >> $OUTPUT_FILE
        done
done

