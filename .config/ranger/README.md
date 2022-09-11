| Hotkey | Description                                                |
| :----: | ---------------------------------------------------------- |
|   ?    | Open the manual or list keybindings, commands and settings |
|   l,   | Enter Launch files                                         |
|  j, k  | Select file in the current directory                       |
|  h, l  | Travel up and down in the directory tree                   |

After startup, ranger creates a directory ~/.config/ranger. To copy the default configuration to this directory issue the following command:

    $ ranger --copy-config=all


| Config File | Description                                              |
| :---------: | -------------------------------------------------------- |
|   rc.conf   | startup commands and key bindings                        |
| commands.py | commands which are launched with :                       |
| rifle.conf  | applications used when a given type of file is launched. |

rc.conf only needs to include changes from the default file as both are loaded. For commands.py, if you do not include the whole file, put this line at the top:

    $ from ranger.api.commands import  *

# Color schemes

Ranger comes with four color schemes: default, jungle, snow and solarized. You can change your color scheme using:

    $ set colorscheme scheme

Custom color schemes can be placed in ~/.config/ranger/colorschemes.
