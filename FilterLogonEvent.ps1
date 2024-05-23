# This script filters the Windows event log for event '4624' which is a successful logon.
# It is useful to detect admin-account logons to monitor privilege escalations on your machine.
# If a logon was successful, it can send an e-mail to the specified recipient (e.g. SOC, IT-department).
# You can configure Windows to execute this script whenever event '4624' is triggered.
# Go to the Event Viewer, right-click an event with id '4624' and select "Attach Task To This Event".

# Mail notification parameters
$PSEmailServer = "MAIL_SERVER"
$SecPW = ConvertTo-SecureString "SENDER_MAIL_PW" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("SENDER_MAIL", $SecPW)
$sender = "DISPLAY_NAME SENDER_MAIL" # e.g. "SECURITY LOGON logon@xyz.com"
$recipient ="DISPLAY_NAME RECIPIENT_MAIL" # e.g. "IT it-services@its.com"

# Filtering event-log to see if logon has been detected
$admin_acc_name = "ADMIN_ACCOUNT_NAME"
$event = Get-WinEvent -LogName Security -FilterXPath "*[System[EventID=4624]]" | 
` Where-Object {$_.Properties[5].Value -like $admin_acc_name} |
` Select-Object -first 1 -Property MachineName, TimeCreated, Message |
` Out-String

if(-not $event -eq "") {
    # Send mail-notification when event is registered (uncomment the following line)
    #Send-MailMessage -Credential $cred -UseSsl -From $sender -To $recipient -Subject 'Admin-Logon Detected' -Body $event

    # Alternatively, write output to command line for manual execution
    Write-Host "Admin-Logon detected!"
    Write-Host "Please review the following report:"
    Write-Host $event
}