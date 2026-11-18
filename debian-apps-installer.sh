#!/usr/bin/env bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'


DISTRO_CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")

DEBIAN_CODENAME=$(. /etc/os-release && echo "$DEBIAN_CODENAME")


# Update repos
echo "updating apt sources..."
sudo apt update
echo

echo "${YELLOW}installing curl...${RESET}"
sudo apt install curl
echo

echo "${YELLOW}installing net-tools...${RESET}"
sudo apt install net-tools -y
echo

echo "${YELLOW}installing ranger...${RESET}"
sudo apt install ranger -y
echo

echo "${YELLOW}installing gcc...${RESET}"
sudo apt install gcc -y
sudo apt install build-essential -y
echo

# Install rust
echo "${YELLOW}installing rust...${RESET}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo


# Install typst
echo "${YELLOW}installing typst...${RESET}"
cargo install --locked typst-cli
echo




# Install brave browser
echo "${YELLOW}installing brave and brave origin browsers...${RESET}"

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources

sudo apt update

sudo apt install brave-browser

sudo apt install brave-origin

echo



# Install signal
echo "${YELLOW}installing signal...${RESET}"

curl https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories:
curl -o signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources
cat signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null

# 3. Update your package database and install Signal:
sudo apt update && sudo apt install signal-desktop

echo



# Insltall docker
echo "${YELLOW}installing Docker...${RESET}"

sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc docker-buildx podman-docker containerd runc | cut -f1)

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$DEBIAN_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo


#flatpak

echo "${YELLOW}installing Kate...${RESET}"
flatpak install flathub org.kde.kate -y
echo



echo "${YELLOW}installing KeepassXC...${RESET}"
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub org.keepassxc.KeePassXC -y
echo


echo "${YELLOW}installing Telegram...${RESET}"
flatpak install flathub org.telegram.desktop -y
echo


echo "${YELLOW}installing Kate...${RESET}"
flatpak install flathub org.gnome.gedit
echo


echo "${YELLOW}installing LocalSend...${RESET}"
flatpak install flathub org.localsend.localsend_app -y
echo


echo "${YELLOW}installing Okular...${RESET}"
flatpak install flathub org.kde.okular -y
echo


echo "${YELLOW}installing Flatseal...${RESET}"
flatpak install flathub com.github.tchx84.Flatseal -y
echo


echo "${YELLOW}installing Flameshot...${RESET}"
flatpak install flathub org.flameshot.Flameshot -y
echo


echo "${YELLOW}installing Save Desktop app...${RESET}"
flatpak install flathub io.github.vikdevelop.SaveDesktop -y
echo


echo "${YELLOW}installing OBS Studio...${RESET}"
flatpak install flathub com.obsproject.Studio -y
echo


# Others
echo "${YELLOW}installing Zed...${RESET}"
curl -f https://zed.dev/install.sh | sh

