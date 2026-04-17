[CmdletBinding()]
param(
[Parameter(Mandatory)]
$vcserver,
$vmuser,
$vmpassword,
$vmnames,
$userconfirmation
)

Import-Module VMware.DeployAutomation
Import-Module VMware.ImageBuilder
Import-Module VMware.VimAutomation.Cis.Core
Import-Module VMware.VimAutomation.Common
Import-Module VMware.VimAutomation.Core
Import-Module VMware.VimAutomation.HA
Import-Module VMware.VimAutomation.License
Import-Module VMware.VimAutomation.Sdk
Import-Module VMware.VimAutomation.Storage
Import-Module VMware.VimAutomation.vds

Function Upgrade-VMTools()
{
 $Servers = $vmnames
 foreach($VMname in $Servers)
 {
  $VMtoolsinfo = Get-VM -Name $VMname | select @{N='ToolsversionStatus';E={$_.Extensiondata.Summary.Guest.ToolsVersionStatus}}
  $VMwareToolsVersionStatus = $VMtoolsinfo.ToolsversionStatus
  $K++
  if($VMwareToolsVersionStatus -eq 'guestToolsNeedUpgrade')
  {
   
   if($userconfirmation -eq 'Yes')
   {
    $updaterunstatus = Update-Tools $VMname -RunAsync -InformationAction:Ignore
    Start-Sleep -Seconds 25
    $VmRestart = Restart-VMGuest -VM $VMName -Confirm:$false
   }
   elseif($userconfirmation -eq 'No')
   {
    $updaterunstatus = Update-Tools $VMname -NoReboot -RunAsync -InformationAction:Ignore
   }
   Write-Host  "$K. Upgrading the VMware Tools on $VMname"
   if($updaterunstatus.state -eq 'Running')
   {
    Write-Host  "$K. Upgrading the VMware Tools on $VMname"
   }
   elseif($updaterunstatus.state -eq 'Queued')
   {
    Write-Host  "$K. Upgrading the VMware Tools on $VMname"
   }
  }
  elseif($VMwareToolsVersionStatus -eq 'guestToolsCurrent')
  {
   Write-Host "$K. VMware Tools Version is already in Current status on",$VMname 
  }
 }
}

Function Connect-Vcenter()
{

 $VCName = Connect-VIServer -Server $vcserver -User $vmuser -Password $vmpassword -WarningAction SilentlyContinue -Force
 $VC = $VCName.Name
 if($VC -ne $null)
 {
  Write-Host  "Successfully connected to $VC"
  $Script:ConnectedVcenter
  Upgrade-VMTools
 }
 else
 {
  Write-Host "No VCenter Connected"
 }
}

Connect-Vcenter
