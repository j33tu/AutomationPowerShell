Write-Host ("starting task changing OU path for all Parent Machins for SCCM") -ForegroundColor White
$vcenter=Read-Host -Prompt "provide vcenter to connect"
Write-Host ("connecting to vcenter $vcenter") -ForegroundColor Cyan
Connect-Viserver $vcenter -credential $cred
$vms = get-folder Templates | get-vm | select name
$vms
$targetpath="OU=Parents,,DC=vclass,DC=local"
foreach ($vm in $vms){
        try{
            write-host ("trying to move $vm computer object to $targetpath ") -ForegroundColor Yellow
            get-ADComputer  $vm | Move-ADObject -TargetPath 'OU=Parents,,DC=vclass,DC=local'
            write-host ("successfully moved VDI Parent computer object to ou $targetpath") -ForegroundColor Green
            }
        catch{
             write-host ("coud not add VDI Parent computer object") -ForegroundColor RED
             }
}