#!/bin/bash

export BROWSER_USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1081.2 Safari/536.5"

function mirror_site() {
  # Requires puf (sudo apt-get install puf)
  puf -pr -r -xg -c -U "$BROWSER_USER_AGENT" "$@"
}

function mirror_site_wget() {
  # Requires wget (sudo apt-get install wget)
  # -r: Turn on recursive retrieving.
  # -p: Download prerequisites needed to display page (e.g. CSS needed to render HTML page).
  # -np: Don't ascend above the starting directory.
  # -k: Rewrite links in local files to work locally (i.e. change links to be relative).
  # -U "$BROWSER_USER_AGENT": Set custom User-Agent.
  # See also: http://explainshell.com/explain?cmd=wget+-r+-p+-np+-k+-U+%22%24BROWSER_USER_AGENT%22+%22%24%40%22
  wget -r -p -np -k -U "$BROWSER_USER_AGENT" "$@"
}

function mirror_site_wget_trusted() {
  # Requires wget (sudo apt-get install wget)
  # -r: Turn on recursive retrieving.
  # -l 100: Specify recursion maximum depth level 100.
  # -p: Download prerequisites needed to display page (e.g. CSS needed to render HTML page).
  # -np: Don't ascend above the starting directory.
  # --trust-server-names: Use server's file name as local filename (for redirects).
  # -E: If server returns HTML page, adjust local filename extension to ".html".
  # -k: Rewrite links in local files to work locally (i.e. change links to be relative).
  # -U "$BROWSER_USER_AGENT": Set custom User-Agent.
  # See also: http://explainshell.com/explain?cmd=wget+-r+-l+100+-p+-np+--trust-server-names+-E+-k+-U+%22%24BROWSER_USER_AGENT%22+%22%24%40%22
  wget -r -l 100 -p -np --trust-server-names -E -k -U "$BROWSER_USER_AGENT" "$@"
}

function download_urls() {
  # Requires aria2 (sudo apt-get install aria2)
  # See also: http://explainshell.com/explain?cmd=aria2c+-s+1+-j+4+-c+-i+%22%24%40%22
  aria2c -s 1 -j 4 -c -i "$@"
}

function download_videos() {
  # Requires aria2 (sudo apt-get install aria2)
  # See also: http://explainshell.com/explain?cmd=aria2c+-s+1+-j+2+-i+%22%24%40%22
  aria2c -s 1 -j 2 -i "$@"
}

#Requires ffmpeg installed if you want the highest quality video from Youtube (sudo apt-get install ffmpeg)
function download_youtube() {
  youtube-dl --write-description --write-info-json -o '%(uploader)s/%(playlist)s/%(title)s %(id)s.%(ext)s' "$@"
}

