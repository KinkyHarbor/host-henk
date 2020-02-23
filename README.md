# Henk

Our first pirate crew member!

## Setup

### Install Flatcar Container Linux

1. Boot into latest custom image of Arch Linux

```bash
# Set a new root password
passwd

# Start SSH server
systemctl start sshd
```

2. Connect with a local terminal

```bash
# Download latest flatcar-install
wget -O flatcar-install "https://raw.githubusercontent.com/flatcar-linux/init/flatcar-master/bin/flatcar-install"

# Download CoreOS Config Transpiler
wget -O ct "https://github.com/coreos/container-linux-config-transpiler/releases/download/v0.9.0/ct-v0.9.0-x86_64-unknown-linux-gnu"

# Make both files executable
chmod a+x ct flatcar-install

# Download config
wget -O henk-clc.yml "https://raw.githubusercontent.com/KinkyHarbor/host-henk/master/henk-clc.yml"

# Complete config
# Use `mkpasswd --method=SHA-512 --rounds=4096` to generate a secure password hash
vim henk-clc.yml

# Transpile the config
./ct -strict < henk-clc.yml > henk-clc.json

# Install Flatcar using
./flatcar-install -d /dev/sdX -C stable -i henk-clc.json

# Reboot server
reboot

```

### Configure SSH client

Append following lines to `~/.ssh/config`

```
Host henk
    HostName henk.kinkyharbor.com
    User robbie
    IdentityFile ~/.ssh/robbie
```

### Configure Flatcar

```bash
# Disable root and core user
sudo passwd -ld root
sudo passwd -ld core

# Change hostname
sudo hostnamectl set-hostname henk

# Set timezone
sudo timedatectl set-timezone Europe/Brussels

# Create opt folder
sudo mkdir -p /opt/bin
```

### Docker Compose

Use [following instructions](https://docs.docker.com/compose/install/#install-compose) and install Docker compose at `/opt/bin/docker-compose`

### Configure and start services

```bash

# Clone this repo
git clone "https://github.com/KinkyHarbor/host-henk.git" ~/henk

# Configure env
cd ~/henk
cp template.env .env
vim .env

# Start services
docker-compose up -d

# Generate Traefik configs
# Make sure DNS entries exist!
source ./setup/traefik/00-traefik.sh
source ./setup/traefik/10-kh-common-frontend.sh
source ./setup/traefik/10-kh-demo-frontend.sh
source ./setup/traefik/10-kh-beta-frontend.sh
source ./setup/traefik/10-kh-prod-frontend.sh
source ./setup/traefik/10-maintenance.sh
```
