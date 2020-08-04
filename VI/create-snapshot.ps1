Write-host ("importing the module ") 
import-module VMware.VimAutomation.Core
Write-host ("provide Credentials to connect to vCenter") 
$cred = get-credential
Connect-viserver "vCenter.vclass.local" -ErrorAction Stop -credential $cred
$vm = Get-VM -Location "vmfolder"
$date = Get-Date -Format FileDate
foreach ($vm in $vm) {
    new-snapshot -vm $vm -name $date -Description " monthly patches"  -confirm:$false 
    Write-host ("Created Snapshot $date for Virtual Machine $vm") 
}