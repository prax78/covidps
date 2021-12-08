function Remove-Patches()
{
  [cmdletbinding()]
param
(
[Parameter(Mandatory)]
$InstalledDate

)

$KB=@()

$hotfixes=get-hotfix

foreach($hotfix in $hotfixes)
{

if($hotfix.InstalledOn -contains $InstalledDate)
{

$KB+=$hotfix.HotFixID

}

}
echo "Below KBs are found that were installed on $($InstalledDate)"
$KB

foreach($patch in $KB)
{

echo "Uninstalling $($patch)"
$patchToUninstall=$patch -replace "KB",""
Start-Process WUSA -ArgumentList "/uninstall /quiet /norestart /kb:$($patchToUninstall)" -Wait


}
echo "patches have been removed"
}

