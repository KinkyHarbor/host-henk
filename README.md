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

# Clone this repo
git clone git@github.com:KinkyHarbor/henk.git

# Complete config
# Use `mkpasswd --method=SHA-512 --rounds=4096` to generate a secure password hash
vim henk/henk-clc.yml

# Transpile the config
./ct -strict < henk/henk-clc.yml > henk-clc.json

# Install Flatcar using
./flatcar-install -d /dev/sdX -C stable -i henk-clc.json

# Reboot server
reboot

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
Use [following instructions](https://docs.docker.com/compose/install/#install-compose) and install Docker compose at `/opt/bin/docker-compose-bin`

