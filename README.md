  

# Godot game engine auto installer ( Linux )
#### Features of installer
- Uses godot website to download latest linux version 32 / 64 bit
- Creates desktop shortcut ( may require you to activate it / permissions )
- Installs into .devel.apps folder on the user home folder
- Can be used to update to the latest version of Godot ( keeps old versions )

#### Run installer from terminal
requires curl
'''
curl -o- https://github.com/slaterbbx/godot.installer.sh/blob/master/godot.sh | bash
'''