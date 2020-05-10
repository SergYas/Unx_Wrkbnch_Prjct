readme.md: guessinggame.sh
	echo "# Project name" > readme.md
	echo "--------------------------------------------------------" >> readme.md
	echo "Make started at" >> readme.md
	date +"%T %m-%d-%Y" >> readme.md
	echo "--------------------------------------------------------" >> readme.md
	echo "guessinggame.sh contains the following number of lines"  >> readme.md
	cat guessinggame.sh | wc -l >> readme.md

