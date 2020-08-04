$vcenter="vcenter1@vclass.local","vcenter2@vclass.local"
$vcenter
$vcenter.gettype()
$records=@()
foreach($vc in $vcenter){
connect-viserver $vc -credential $cred
$Count=(get-vmhost).Count
$record=""|select vcName, Count
$record.vcName = $vc
$record.Count = $Count
$records += $record
}
$date = Get-Date -Format FileDate
$records | Format-Table | Export-Csv -Path ./$date.csv
Send-MailMessage -From 'sender@vclass.local ' -To 'reciever@vclass.local' -Subject 'vCenter host count' -Body "Daiyl vCenter Host Count report Attached Sending now \n $recrod" -Attachments .\$date.csv  -SmtpServer  smtpserver.vclass.local



