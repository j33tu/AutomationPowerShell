# Author: Jitendra Singh
# Blog  : www.xtra-virtual.com
#Purpose : Running below codes Creates rule no 1 in NSX DLR firewall to stop all traffic from  Mentioned Security  Group
# Make sure NSX module is imported on system where script is running
# click here on how to install PowerNSX on your system https://github.com/vmware/powernsx or copy  below code from https://github.com/j33tu/engineering
#-DisableVIAutoConnect helps you not to connect to vCenter server 
$credential = Get-Credential 
Connect-NsxServer "nsx sever Ip or FQDN" -Credential $credential -DisableVIAutoConnect 
$SecurityGroup = Get-NsxSecurityGroup "Test"
Get-NsxFirewallSection $FireWallSection | New-NsxFirewallRule -name "Test" -Source $SecurityGroup -Action deny