#!/bin/bash

#Create a one MiB size file, fill it with lines of 15 random alphanumerics characters.

#Sort the file, remove all the "a" and "A" starting lines and save the result on a new file.

#Inform how many lines were deleted.

#One MiB size definition.
MiB=1048576

#Write one random line to the file "ResultsA.txt"
echo "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1)" > ResultsA.txt

#Let's get the size of one single line.
OneLineZize=$(du -b ResultsA.txt | awk '{print $1}')

#Let's get the number of lines needed to get the one MiB size file.
End=$(( $MiB/$OneLineZize -1 )) #Minus one due the already line writted.

#Writting the remaining lines.
for i in $(seq 1 $End);
do 
echo "$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1)" >> ResultsA.txt
done

#Sort the file.
sort -o ResultsA.txt ResultsA.txt

#Remove all lines that start with an “a”, no matter if it is in uppercase or lowercase.
sed '/^[aA]/ d' ResultsA.txt >ResultsB.txt 

#How many lines were removed?
OriginalLines=$(wc -l ResultsA.txt | awk '{print $1}')
FinalLines=$(wc -l ResultsB.txt | awk '{print $1}')
RemovedLines=$(($OriginalLines - $FinalLines))

echo "$RemovedLines lines where removed."

exit 0
