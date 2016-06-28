#These are all designed for the bash shell

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

#Requires ffmpeg built with mp3 encoding support (Add universe repository to your apt sources, then sudo apt-get install ffmpeg libavcodec-extra-53)
#To get mp3 encoding support:
#  For Ubuntu 12.10 Quantal and Ubuntu 12.04 Precise:
#    1. Add universe repository to your apt sources (https://help.ubuntu.com/community/Repositories/Ubuntu#Ubuntu_Software_Tab)
#    2. sudo apt-get update
#    3. sudo apt-get install ffmpeg libavcodec-extra-53 libavdevice-extra-53 libavfilter-extra-2 libavformat-extra-53 libavutil-extra-51 libpostproc-extra-52 libswscale-extra-2
#  For Ubuntu 11.10 Oneiric:
#    1. Add universe repository to your apt sources (https://help.ubuntu.com/community/Repositories/Ubuntu#Ubuntu_Software_Tab)
#    2. Add multiverse repository to your apt sources (https://help.ubuntu.com/community/Repositories/Ubuntu#Ubuntu_Software_Tab)
#    3. sudo apt-get update
#    4. sudo apt-get install ffmpeg libavcodec-extra-53 libavdevice-extra-53 libavfilter-extra-2 libavformat-extra-53 libavutil-extra-51 libpostproc-extra-52 libswscale-extra-2
#  For Ubuntu 11.04 Natty and Ubuntu 10.10 Maverick:
#    These distributions have been EOL-ed and so the repositories are offline.
#  For Ubuntu 10.04 Lucid:
#    1. Add universe repository to your apt sources (https://help.ubuntu.com/community/Repositories/Ubuntu#Ubuntu_Software_Tab)
#    2. Add multiverse repository to your apt sources (https://help.ubuntu.com/community/Repositories/Ubuntu#Ubuntu_Software_Tab)
#    3. sudo apt-get update
#    4. sudo apt-get install ffmpeg libavcodec-extra-52 libavdevice-extra-52 libavfilter-extra-0 libavformat-extra-52 libavutil-extra-49 libpostproc-extra-51 libswscale-extra-0
function extract_audio() {
  ffmpeg -i "$1" -acodec copy "$1.mp3"
}

#Requires openvpn and an openvpn-compatible proxy configuration file (e.g. HideMyNet) (sudo apt-get install openvpn)
function activate_vpn() {
  sudo openvpn --config "$1" --redirect-gateway def1 bypass-dns bypass-dhcp --daemon
  sleep 30
  sudo ifconfig tun0 mtu 1300
  sudo ifconfig eth1 mtu 1300
  sudo ifconfig wlan0 mtu 1300
}


function crush_video() {
  ffmpeg -i "$@" -c:a libfaac -b:a 96k -c:v libx264 -crf 26 -preset slower -r:v 24 "$@.mp4"
}
