#!/usr/bin/env bash
# File: guessinggame.sh
game_body ()
{
	while [[ $wish_answer = y ]] || [[ $wish_answer = Y ]] ; do
		echo -n "Now we in $(pwd) directory. Try to guess how many files are here (integer value, please): "; read game_answer; game_answer_checker
		true_game_body
		echo -n "Do you wanna play again? (y/n):"; read wish_answer
		dir_changer
	done
	echo "Bye. Have a nice day!"; cd $current_dir; exit
}
true_game_body ()
{
	true_answer=$(ls -la | cut -c 1 | grep - | wc -l); 
	while [[ $true_answer -ne $game_answer ]]; do
		if [[ $true_answer -lt $game_answer ]]; then
			echo -n "Not so much, try again: "
		else echo -n "Try a little more: "
		fi
	read game_answer; game_answer_checker
	done
	echo "Yeah, $true_answer is true!"
}
game_answer_checker () #checks for integer answer, one attampt to re-enter
{
	if ! [[ $(echo $game_answer | egrep ^[0-9]+$) ]]; then
		echo -n "If you really wanna play, enter integer value: "; read game_answer
		if ! [[ $(echo $game_answer | egrep ^[0-9]+$) ]]; then
			echo "I do not play this way. :( Bye..."; exit
		fi
	fi
}
dir_changer ()
{
	changed_dir='/'; changed_dir_temp='/'; dir_array=($(ls -F $changed_dir | grep /)) 
	while [[ ${#dir_array[*]} -ge 1 ]] && [[ $((RANDOM%10)) -lt 8 ]]; do # if current dir contains another dir, 80% chanсe to continue
		changed_dir_temp+=${dir_array[$((RANDOM%${#dir_array[*]}))]} #temp variable for errors avoid
		if [[ -d $changed_dir_temp ]] && [[ -r $changed_dir_temp ]]; then #directory exists and directory readable check
			changed_dir=$changed_dir_temp #continue if no errors
		else changed_dir_temp=$changed_dir #step back if error
		fi
		dir_array=($(ls -F $changed_dir | grep /)) #step forward
	done
	cd $changed_dir
}
current_dir=$(pwd)
echo "Hello!"
echo -n "Do you wanna play? (y/n):"; read wish_answer
game_body