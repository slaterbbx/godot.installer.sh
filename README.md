# Linux Godot game engine auto installer
#### Features of installer
- Bash
- Uses godot website to download latest linux version 32 / 64 bit ( auto detect )
- Creates desktop shortcut ( may require you to activate it / permissions )
- Installs into Godot folder on the user home folder
- Can be used to update to the latest version of Godot ( keeps old versions )
- Should work in most if not all versions of linux

#### Run installer from terminal
Requires curl
```
sudo apt install curl
```
Reguires git
```
sudo apt install git
```
Install godot with terminal and git clone
- 'rm -rf' cleans up the install files
```
git clone https://github.com/slaterbbx/godot.installer.sh
cd godot.installer.sh
bash godot.sh
cd ..
rm -rf godot.installer.sh
```

Right click the desktop icon and select "allow launching" ( ubuntu ).
Done.