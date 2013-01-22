#These are all designed for the bash shell

export BROWSER_USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1081.2 Safari/536.5"

#Requires wget (sudo apt-get install wget)
function mirror_site() {
  wget -r -k -p -np -U "$BROWSER_USER_AGENT" "$@"
}

#Requires aria2 (sudo apt-get install aria2)
function download_urls() {
  aria2c -s 1 -j 4 -i "$@"
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
