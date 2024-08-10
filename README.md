# Debian 12 server installation and configuration instruction

Instruction for installing and setup debian12 system on home lab server

# Change sources.list

Basically, Debian as default set sources.list for apt  to load files from cdrom, let's change it to base debian repos
```bash
sudo nano /etc/apt/sources.list
```

And change config to this:
```bash
deb http://deb.debian.org/debian bookworm main non-free-firmware
deb-src http://deb.debian.org/debian bookworm main non-free-firmware

deb http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware
deb-src http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware
```

To apply changes run update
```bash
sudo apt update
```

# Add new user to sudoers

At first, install sudo as root
```bash
sudo apt install sudo
```

Add admin user (created while installation) to sudoers under root:
```bash
# User privilege specification
root         ALL=(ALL:ALL) ALL
admin-user   ALL=(ALL:ALL) ALL
```

# Create more users

To create new user with home directory run command:
```bash
sudo useradd -m newuser
```

Set password:
```bash
sudo passwd newuser
```

Add to groups
```bash
sudo usermod -aG *gid* newuser
```

Set shell for user:
```bash
sudo usermod -s /bin/bash newuser
```

Switch to new user:
```bash
su newuser
```

# Turn off Sleep, Hibernate, and Suspend

```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

# Create local network disk with Samba

Install Samba
```bash
sudo apt install samba
```

Create folder somewhere on server
```bash
mkdir ~/netfoler
```

Add configuration for our netfolder into smb.conf
```bash
sudo nano /etc/samba/smb.conf
```

At the end of file add:
```bash
[netfolder]
   path = /path/to/netfolder
   writable = yes
   public = no
```

Set password to samba for user
```bash
sudo smbpasswd -a dmitriy
```

Restart smbd to apply changes
```bash
sudo systemctl restart smbd
```

# Mount Drive to specifically directory

Check drive id with lsblk
```bash
lsblk
```

Then issue mount command
```bash
sudo mount /dev/*drive id* /path/to/mount/folder
```



