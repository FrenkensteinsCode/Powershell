# Mail notification parameters
$PSEmailServer = "MAIL_SERVER"
$SecPW = ConvertTo-SecureString "SENDER_MAIL_PW" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("SENDER_MAIL", $SecPW)
$sender = "DISPLAY_NAME SENDER_MAIL" # e.g. "BACKUP backup@xyz.com"
$recipient ="DISPLAY_NAME RECIPIENT_MAIL" # e.g. "John john.doe@jdoe.com"
$body_on_failure = "FAILURE_MESSAGE"
$body_on_success = "SUCCESS_MESSAGE"

# Backup parameters
$TimeStamp = get-date -f yyyyMMddhhmm
$Source = "SOURCE_DIR" # e.g. "C:\Users\John\Documents\*"
$Destination = "DEST_DIR" + $TimeStamp
$DateToDelete = (Get-Date).AddDays(-2) # Set delete date to two days

# Backup process
New-Item -ItemType directory -Path $Destination -Force
Copy-Item -Path $Source -Destination $Destination -Force -Recurse
if(-not $?) {
    Send-MailMessage -Credential $cred -UseSsl -From $sender -To $recipient -Subject 'Backup incomplete' -Body $body_on_failure
} else {
    Send-MailMessage -Credential $cred -UseSsl -From $sender -To $recipient -Subject 'Backup completed' -Body $body_on_success
}

# Remove backups of two days prior recursively
Get-ChildItem $Destination -Recurse | Where-Object { $_.LastWriteTime -lt $DateToDelete } | Remove-Item -Recurse -Force
