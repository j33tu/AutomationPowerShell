function Copy-NsxIpset {
    [cmdletBinding()] 
    param (
      [parameter(Mandatory = $true)]
      [string] $PrimaryNsxManager,
      [parameter(Mandatory = $true)]
      [string] $SecondaryNsxManager,
      [parameter (Mandatory = $true)]
      [pscredential] $credential
    )
    begin
    {
        Connect-NsxServer $PrimaryNsxManager -DisableVIAutoConnect -Credential $credential
        $NsxIpSets = @(Get-NsxIpSet)
        Disconnect-NsxServer
    } 
    process
    {
        Connect-NsxServer $SecondaryNsxManager -DisableVIAutoConnect -Credential $credential
        Write-Verbose -Message "Syncing NsxIpSets from $PrimaryNsxManager to $SecondaryNsxManager"
    foreach($Nsxipset in $NsxIpSets)
    {
        $IpSetExists = Get-NsxIpSet -Name $Nsxipset.Name -ErrorAction SilentlyContinue
        if ($IpSetExists)
        {
            Write-Verbose -Message "Found the IPSet with Name $($NsxIpSet.Name)....Adding the Ip address"
            try{
                Add-NsxIpSetMember -IPSet $IpSetExists -IPAddress $Nsxipset.value -ErrorAction stop -whatif
                Write-Verbose -Message "updated the Ip set with name $($NsxIpset.name) and IpAddress $($NsxIpSet.value)"
            }
            catch{
                 Write-Verbose -Message "Failed ! updating the Ip sets"
            }
        }
        else{
            Write-Verbose -Message "Not Found ip set, Creating NsxIpSet $($NsxIpSet.Name)"
            New-NsxIpSet -Name $NsxIpSet.Name -IPAddress  $NsxIpSet.value
        }
    } 
    }
end {
    Write-Verbose -Message "Sync Finished"
} 
}