Write-Host ("finding path of VMs in AD ") -ForegroundColor White
$vcenter = Read-Host -Prompt "provide vcenter to connect"
Write-Host ("connecting to vcenter $vcenter") -ForegroundColor Cyan
Connect-Viserver $vcenter -credential $cred
get-folder Templates | get-vm | select name >> C:\temp\vms.txt
$vms = Get-Content C:\temp\vms.txt
foreach ($vm in $vms) {
        write-host "trying name $vm"
        try {
                Get-ADComputer -Identity $vm | select name , DistinguishedName
        }
        catch {
                Write-Host ("cout not find object $vm AD thats why trying to add ") -ForegroundColor Yellow
                $vm >> missed.txt
                New-ADComputer -Name $vm -SamAccountName $vm -Path "OU=Parents,DC=vclass,DC=local" -Enabled $true -Location "VMlocation"
        }
       
}