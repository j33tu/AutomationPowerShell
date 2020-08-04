# Author:   Jitendra Singh
# Blog:   www.jitendra-singh.com
# Version:  1.0.1
# PowerCLI v6.0
# PowerNSX v3.0
# Purpose: Create rule no. 1 in nsx DLR firewall to stop all traffic from VDI Pool 
# Make sure NSX module is imported on system where script is running  else 
#install-module powernsx -scope currentuser
Connect-NsxServer nsxserver.com -Username admin -Password #$#$@#$$$## -DisableVIAutoConnect
$sg=Get-NsxSecurityGroup "securitygrouptobeblocked"
PowerCLI C:\> get-nsxfirewallsection $FirewallSection | New-NSXFirewallRule -Name "Test" -Source  $sg -Action Deny