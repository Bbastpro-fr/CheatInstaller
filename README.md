# CheatInstaller
## Script to install Cheat on your system

CheatInstaller is a standalone installation script.
Writed in bash.
## Features

- Automatically download dependencies
- Automatically manages the user group
- Script is accompanied by a script to automatically add a person

>The realization of this script is part of my studies
>and is also part of a desire to create many scripts
>automating tasks or preparations of machines

**Cheat is an interactive cheatsheets available at : https://github.com/cheat/cheat.git**
## Guide
### Utilisation
**To install**
```bash
sudo ./CheatInstaller.sh -i
```
**To display help**
```bash
sudo ./CheatInstaller.sh -i
```
**To uninstall**
```bash
sudo ./CheatInstaller.sh -i
```
**IMPORTANT: Be careful when trying to uninstall. This function may remove useful packages/dependencies for other programs.**
**You have to open the script manually and execute each line by yourself.**


**After installation, to add user**
```bash
sudo ./CheatAddUser.sh <username>
```

### Installation
```bash
git clone https://github.com/Bbastpro-fr/CheatInstaller.git
chmod 755 CheatInstaller.sh CheatAddUser.sh
```

## Credits
**PROUST Bastien**

*Copyright 2021-2021 Bbastpro.*
*All rights reserved. Any reproduction, dissemination, sharing, distribution, commercialization without explicit permission is prohibited.*
