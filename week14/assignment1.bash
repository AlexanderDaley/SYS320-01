#! /bin/bash
clear

# filling courses.txt
bash Courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function displayCoursesOfInst()
{
	read courseName

	echo "Courses in $courseName:"
	cat "$courseFile" | grep "$courseName" | cut -d ';' -f1,2,5,6,7 | sed 's/;/ | /g'

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function courseCountOfInst()
{
	read courseNum

	echo "Available courses in $courseNum:"
	cat "$courseFile" | grep "$courseNum" > temp.txt
	while read -r line
	do
		num=$(echo "$line" | cut -d ';' -f4)
		if [ $num -gt 0 ]; then
			echo "$line" | cut -d ';' -f1-15 | sed 's/;/ | /g'
		fi
	done < temp.txt
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a classroom"
	echo "[4] Display available courses of a subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		echo "Please input a class name: "
		displayCoursesOfInst

	elif [[ "$userInput" == "4" ]]; then
		echo "Please input a subject name: "
		courseCountOfInst

	elif [["$userInput" == "5" ]]; then
		echo "Goodbye"
		break
	else
		echo "Wrong input, try again"
	fi
done
