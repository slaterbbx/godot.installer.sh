#!/bin/bash

# NEEDS!
# Menu link with catagory Game Dev
# Make godot command to open godot from terminal
# Make install for source
# Fix download link to check github downloads instead of the website for release numbers
# uninstall process 

# change downloader to get from github repos
# make option to right click desktop icon and have options to open source folder

linebreak="echo "

# Install Godat game engine &&& Vpainter https://www.youtube.com/watch?v=vVxemrkB3Mg

echo "◦ Install Godot Game Engine"

# get system data for auto install
operatingSystem=$(uname -m)

# get logged in username for link purposes
userName=$(who | cut --delimiter " " --fields 1)
# programExec=''

scrapeLink="https://godotengine.org/download/linux"
# game engine zip link
linkRegex1='downloads\.tuxfamily.*(64|32)'
excludeSearch1='mono'

# save HTML data to temp file for link scraping
htmlToScrape="./tempfiles/scraper.html"

mkdir ./tempfiles
temp="./tempfiles/"

# download html page with curl and save to tempfile for parsing
curl -s $scrapeLink > $htmlToScrape

# using -E for regex complexity
# Get godot engine links from html file
grep -i -E $linkRegex1 $htmlToScrape | 
grep -i -o '".*"' | # displays only text within "" due to -o option with grep
grep -v $excludeSearch1 | # exclude from search by flipping the results
sed 's/"//g' > ${temp}godotlinks.txt # removes quotes from link 

# downloading files
(cd ./tempfiles;
	# download the logo svg file into ./tempfiles
	curl -LOs https://godotengine.org/themes/godotengine/assets/press/icon_color_outline.svg

	if [[ $operatingSystem =~ .*64 ]]; then
		# download 64 bit zip file
		echo " ‣ 💾 Downloading 64bit Godot game engine"
		$linebreak
		grep -i -E '.*64' godotlinks.txt | xargs curl -LO
		$linebreak
	elif [[ $operatingSystem != ".*64" ]]; then
		# download 32 bit zip file
		echo " ‣ 💾 Downloading 32bit Godot game engine"
		$linebreak
		grep -i -E '.*32' godotlinks.txt | xargs curl -LO
		$linebreak
fi

# unzip the downloaded godot file
zipValidator=$(find -iname "*.zip" | sed 's/^[.]//g') # [.] needs removed for test -f check to work
if ! test -f "$zipValidator"; then
	zipFile=$(echo $zipValidator | sed 's/^[/]//g') # remove starting / for unzip process
	unzip -qqo $zipFile
fi
)

# create install folder
(cd /home/${userName}/;
	mkdir .devel.apps
	(cd .devel.apps;
		mkdir godot
	)
)

# get unzipped filename from zip file
unzippedFilename=$(find tempfiles/ -iname "*.zip" |
sed 's/tempfiles//g' |
sed 's/[/]//' |
sed 's/.zip//')

# move godot game engine and svg file into the /home/username/.devel.apps/godot folder
mv ./tempfiles/$unzippedFilename /home/${userName}/.devel.apps/godot
mv ./tempfiles/icon_color_outline.svg /home/${userName}/.devel.apps/godot/logo.svg

# create desktop icon
# printf gives us /n newlines which are needed for the .desktop file
echo " ‣ Creating desktop shortcut"
printf "#!/usr/bin/env xdg-open
[Desktop Entry]
Type=Application
Terminal=false
StartupNotify=false
Icon=/home/${userName}/.devel.apps/godot/logo.svg
Exec=/home/${userName}/.devel.apps/godot/${unzippedFilename}
Categories=Game Development
Name[en_US]=Godot
Name=Godot" | cat > ~/.local/share/Godot.desktop # ‼❗ do this process in another folder to check if the icon is locked, if we can use another folder and move it from the ./tempfiles, that would be better. / also, maybe we dont need to do anything accept change the user and permissions anyway.
# we need to change the owner to the current user to eliminate "lock" icon for root
chown $userName ~/.local/share/Godot.desktop
# we build the file in the ~/.local/ folder and move it to the desktop to eliminate .desktop extension visability
mv ~/.local/share/Godot.desktop /home/slaterbbx/Desktop/
# set as executable just incase linux system compatability
chmod +x /home/slaterbbx/Desktop/Godot.desktop
echo "  • Desktop shortcut created "

rm -rf ./tempfiles

# UNINSTALL PROCESS
# remove folder to clean up
# ~/.local/share/godot