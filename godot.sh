#!/bin/bash

# If you want to help add something to this, here are my current thoughts
# Add some of the following
# Make godot command to open godot from terminal
# - add options to pick version of godot + source
# Make install for source
# - add right click option on desktop icon "view source" link to folder in terminal
# uninstall process 
# change downloader to get from github repos
# make options to install popular plugins with godot like
# - godot_voxel map generator tool https://github.com/Zylann/godot_voxel
# - Vpainter https://www.youtube.com/watch?v=vVxemrkB3Mg and or Material maker for godot


linebreak="echo "

# Install Godat game engine

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

temp="tempfiles"
mkdir "${temp}"

# save HTML data to temp file for link scraping
htmlToScrape="./${temp}/scraper.html"

# download html page with curl and save to tempfile for parsing
curl -s $scrapeLink > $htmlToScrape

# using -E for regex complexity
# Get godot engine links from html file
grep -i -E $linkRegex1 $htmlToScrape | 
grep -i -o '".*"' | # displays only text within "" due to -o option with grep
grep -v $excludeSearch1 | # exclude from search by flipping the results
sed 's/"//g' > ./${temp}/godotlinks.txt # removes quotes from link 

# downloading files
(cd ./${temp};
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

installDirectory="Godot"

# create install folder
(cd /home/${userName}/;
	mkdir ${installDirectory}
)

# get unzipped filename from zip file
unzippedFilename=$(find tempfiles/ -iname "*.zip" |
sed 's/tempfiles//g' |
sed 's/[/]//' |
sed 's/.zip//')

# move godot game engine and svg file into the /home/${username}/${installDirectory}folder
mv ./${temp}/$unzippedFilename /home/${userName}/${installDirectory}
mv ./${temp}/icon_color_outline.svg /home/${userName}/${installDirectory}/logo.svg

# create desktop icon
# printf gives us /n newlines which are needed for the .desktop file
echo " ‣ Creating desktop shortcut"
printf "#!/usr/bin/env xdg-open
[Desktop Entry]
Type=Application
Terminal=false
StartupNotify=false
Icon=/home/${userName}/${installDirectory}/logo.svg
Exec=/home/${userName}/${installDirectory}/${unzippedFilename}
Categories=Game Development
Name[en_US]=Godot
Name=Godot" | cat > ~/Desktop/Godot.desktop
# set as executable just incase linux system compatability
# chmod +x /home/${userName}/Desktop/Godot.desktop
echo "  • Desktop shortcut created "

rm -rf ./${temp}

# UNINSTALL PROCESS
# remove folder to clean up
# remove folder ${installDirectory}
# ~/.local/share/godot