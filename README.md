# Powershell
Powershell scripts which make my everyday life easier 

## W10Backup.ps1
* Backup designated folders/files to a location of your choice (e.g. external drives/NAS/cloud etc.)
* Mail-notification on success/failure
* Timestamps
* Deletion of old backups to not waste resources

#### Usage
* Download or clone the file/repo to your disk
* Open the file and fill in the capitalized parameters with your own information
* Execute the powershell-script via double left-click or by using the Powershell itself: <code>./W10Backup.ps1</code>

#### Considerations
* If you want to use the mail-notifications, you should create a designated sender-account with a high-entropy password. I advise not to use your standard-mail-account for the sender
* Tested on Win10 (22H2)

# Bash
Bash scripts which I mainly use in my WSL environment

## sysupdate.sh
* I was too lazy to always type in the update-commands. Therefore I created this script which can be comfortably started and even used in crontabs.

#### Usage
* Download or clone the file/repo to your disk
* Execute the script via <code>bash sysupdate.sh</code>
* Follow the prompts in the script
