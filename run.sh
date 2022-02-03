#!/bin/bash

# will finish todayish
#FU GIT


# GH_USER=godotengine \
# GH_REPO=godot \
# GH_BRANCH=REPLACE_WITH_BRANCH \
# curl https://github.com/${GH_USER}/${GH_REPO}/releases/download/${GH_BRANCH}.tar.gz \
# -LO "${GH_REPO}-${GH_BRANCH}.tar.gz" && \
# tar -xzvf ./"${GH_REPO}-${GH_BRANCH}.tar.gz" && \
# rm ./"${GH_REPO}-${GH_BRANCH}.tar.gz"



scrapeLink="https://github.com/godotengine/godot/releases"
# game engine zip link
linkRegex1='.*d-inline.*link--primary'

# save HTML data to temp file for link scraping
htmlToScrape="./tempfiles/scraper.html"

mkdir ./tempfiles
temp="./tempfiles/"

# download html page with curl and save to tempfile for parsing
curl -s $scrapeLink > $htmlToScrape

# using -E for regex complexity
grep -i -E $linkRegex1 $htmlToScrape | 
sed '0,/>/s//' > ${temp}links.txt # removes quotes from link 