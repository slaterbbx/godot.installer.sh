# Godot game engine auto installer ( Linux )
#### Features of installer
- Uses godot website to download latest linux version 32 / 64 bit ( auto detect )
- Creates desktop shortcut ( may require you to activate it / permissions )
- Installs into Godot folder on the user home folder
- Can be used to update to the latest version of Godot ( keeps old versions )

#### Run installer from terminal
requires curl
```
git clone https://github.com/slaterbbx/godot.installer.sh
cd godot.installer.sh
bash godot.sh
cd ..
rm -rf godot.installer.sh
```
Right click the desktop icon and select "allow launching".
Done.