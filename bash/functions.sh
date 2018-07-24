#!/bin/bash

export BROWSER_USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36"

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

function download_url_safe_filename() {
  # Requires aria2 (sudo apt-get install aria2) and https://github.com/bloopletech/config/blob/master/exec/safe-filename-for-url
  aria2c -s 1 -j 1 -c -o "$(safe-filename-for-url "$1")" "$1"
}

function download_urls() {
  export -f download_url_safe_filename
  parallel -j 4 -a "$1" download_url_safe_filename
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

function unzip_files() {
  find -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
}
