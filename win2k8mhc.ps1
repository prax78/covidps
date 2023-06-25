
#Author: prakash.iyengar@kyndrylcom
Remove-Item secpol.cfg -Force -ErrorAction SilentlyContinue
 function GetFileReadStatus()
   {

     [cmdletbinding()]
  param
    (
    [Parameter(Mandatory)]
    $File 
    )
   
   $sysroot=  (get-acl $File -ErrorAction SilentlyContinue |select AccessToString).AccessToString -join '' 
   
  # $sysroot.Gettype()

   if($sysroot.Contains("BUILTIN\Users Allow  ReadAndExecute, Synchronize") -or $sysroot.Contains("BUILTIN\Users:(I)(RX)") -or $sysroot.Contains("NT AUTHORITY\Authenticated Users Allow  ReadAndExecute, Synchronize") -or $sysroot.Contains("BUILTIN\Users:(OI)(CI)(RX)"))
   {
    Write-Host "$($file) Compliant" -BackgroundColor Green
   }
   else
   {
    Write-Host "$($file) Voilation" -BackgroundColor Red
   }
 
  
   
   
   }

    function GetFileReadStatusNot()
   {
   [cmdletbinding()]
    param
    (
    [Parameter(Mandatory)]
    $File 
    )

   $sysroot=  (get-acl $File |select AccessToString).AccessToString -join ''

   
   if(-not $sysroot.Contains("BUILTIN\Users Allow  ReadAndExecute, Synchronize"))
   {
    Write-Host "$($file) Compliant" -BackgroundColor Green
   }
   else
   {
    Write-Host "$($file) Voilation" -BackgroundColor Red
   }
  
   
   $sysroot=""
   }

if(-not (Test-Path secpol.cfg))
{
secedit /export /cfg secpol.cfg



}
else
{


$fileread=gc c:\temp\secpol.cfg

foreach($f in $fileread)
{

  #"Store password using reversible encryption"
  if($f.Contains("ClearTextPassword"))
    {
        $pwdclear=$f.Split(' ')
            if([int]$pwdclear[2] -eq 0)
                {
                     Write-Host "Store password using reversible encryption Compliant Value in Server $($pwdclear[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Store password using reversible encryption violation Value in Server $($pwdclear[2])" -BackgroundColor Red
                }



    }


     #PassWordHistory

    if($f.Contains("PasswordHistorySize"))
    {
        $pwdhistory=$f.Split(' ')
            if([int]$pwdhistory[2] -ge 10)
                {
                     Write-Host "PassWordHistory Compliant Value in Server $($pwdhistory[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "PassWordHistory violation Value in Server $($pwdhistory[2])" -BackgroundColor Red
                }



    }

    #Minimum password age

     if($f.Contains("MinimumPasswordAge"))
    {
        $pwdagemin=$f.Split(' ')
            if([int]$pwdagemin[2] -eq 1)
                {
                     Write-Host "MinimumPasswordAge Compliant Value in Server $($pwdagemin[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "MinimumPasswordAge violation Value in Server $($pwdagemin[2])" -BackgroundColor Red
                }



    }


    
    #Maximum password age

     if($f.Contains("MaximumPasswordAge"))
    {
        $pwdagemax=$f.Split(' ')
            if([int]$pwdagemax[2] -eq 90)
                {
                     Write-Host "MaximumPasswordAge Compliant Value in Server $($pwdagemax[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "MaximumPasswordAge violation Value in Server $($pwdagemax[2])" -BackgroundColor Red
                }



    }



    #Minimum password length
     if($f.Contains("MinimumPasswordLength"))
    {
        $pwdlength=$f.Split(' ')
            if([int]$pwdlength[2] -ge 8)
                {
                     Write-Host "MinimumPasswordLength Compliant Value in Server $($pwdlength[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "MinimumPasswordLength violation Value in Server $($pwdlength[2])" -BackgroundColor Red
                }



    }

    #Account lockout threshold

     if($f.Contains("LockoutBadCount"))
    {
        $lockcount=$f.Split(' ')
            if([int]$lockcount[2] -eq 5)
                {
                     Write-Host "Account lockout threshold Compliant Value in Server $($lockcount[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Account lockout threshold violation Value in Server $($lockcount[2])" -BackgroundColor Red
                }



    }


     #Account lockout duration

     if($f.Contains("LockoutDuration"))
    {
        $lockdurationt=$f.Split(' ')
            if([int]$lockdurationt[2] -eq 0)
                {
                     Write-Host "Account lockout duration Compliant Value in Server $($lockdurationt[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Account lockout duration violation Value in Server $($lockdurationt[2])" -BackgroundColor Red
                }



    }

     #Audit Account logon events
      if($f.Contains("AuditAccountLogon"))
    {
        $acclogonevents=$f.Split(' ')
            if([int]$acclogonevents[2] -eq 3)
                {
                     Write-Host "Audit Account logon events Compliant Value in Server $($acclogonevents[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Account logon events violation Value in Server $($acclogonevents[2])" -BackgroundColor Red
                }



    }
   
   #Audit Logon events
    if($f.Contains("AuditLogonEvents"))
    {
        $auditlogevents=$f.Split(' ')
            if([int]$auditlogevents[2] -eq 3)
                {
                     Write-Host "Audit Logon events Compliant Value in Server $($auditlogevents[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Logon events violation Value in Server $($auditlogevents[2])" -BackgroundColor Red
                }



    }

    #Audit Account Management
     if($f.Contains("AuditAccountManage"))
    {
        $auditaccmgmt=$f.Split(' ')
            if([int]$auditaccmgmt[2] -eq 3)
                {
                     Write-Host "Audit Account Management Compliant Value in Server $($auditaccmgmt[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Account Management violation Value in Server $($auditaccmgmt[2])" -BackgroundColor Red
                }



    }

    #Audit Directory service access
     if($f.Contains("AuditDSAccess"))
    {
        $auditdsaccess=$f.Split(' ')
            if([int]$auditdsaccess[2] -eq 2)
                {
                     Write-Host "Audit Directory service accessn Compliant Value in Server $($auditdsaccess[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Directory service accessn violation Value in Server $($auditdsaccess[2])" -BackgroundColor Red
                }



    }


    #Audit Object access

     if($f.Contains("AuditObjectAccess"))
    {
        $auditobjaccess=$f.Split(' ')
            if([int]$auditobjaccess[2] -eq 2)
                {
                     Write-Host "Audit Object access Compliant Value in Server $($auditobjaccess[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Object access violation Value in Server $($auditobjaccess[2])" -BackgroundColor Red
                }



    }


    #Audit Policy change

     if($f.Contains("AuditPolicyChange"))
    {
        $auditpolchg=$f.Split(' ')
            if([int]$auditpolchg[2] -eq 3)
                {
                     Write-Host "Audit Policy change Compliant Value in Server $($auditpolchg[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Policy change violation Value in Server $($auditpolchg[2])" -BackgroundColor Red
                }



    }


    #Audit Privilege use

     if($f.Contains("AuditPrivilegeUse"))
    {
        $auditprvuse=$f.Split(' ')
            if([int]$auditprvuse[2] -eq 3)
                {
                     Write-Host "Audit Privilege use Compliant Value in Server $($auditprvuse[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Privilege use violation Value in Server $($auditprvuse[2])" -BackgroundColor Red
                }



    }


    #Audit Process Tracking

     if($f.Contains("AuditProcessTracking"))
    {
        $auditprtr=$f.Split(' ')
            if([int]$auditprtr[2] -eq 0)
                {
                     Write-Host "Audit Process Trackingn Compliant Value in Server $($auditprtr[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit Process Tracking violation Value in Server $($auditprtr[2])" -BackgroundColor Red
                }



    }


    #Audit System events
     if($f.Contains("AuditSystemEvents"))
    {
        $auditsysevents=$f.Split(' ')
            if([int]$auditsysevents[2] -eq 2)
                {
                     Write-Host "Audit System events Compliant Value in Server $($auditsysevents[2])" -BackgroundColor Green
                }
            else
                {
                     Write-Host "Audit System events violation Value in Server $($auditsysevents[2])" -BackgroundColor Red
                }



    }





}


}


# Service account Password expiry true
    $accounts=gwmi win32_useraccount -Filter "LocalAccount=$true and PasswordExpires=$true"|select PasswordExpires,Name
   foreach($acc in $accounts)
   {
    Write-Host "Account Name: $($acc.Name) PasswordExpiry $($acc.PasswordExpires)" -BackgroundColor Yellow
   }

    # Service account Password expiry False
       $accounts=gwmi win32_useraccount -Filter "LocalAccount=$true"|select PasswordExpires,Name
   foreach($acc in $accounts)
   {
    if($acc.Name -eq "Guest" -and $acc.PasswordExpires -eq $false)
    {
     Write-Host "Account Name: $($acc.Name) PasswordExpiry $($acc.PasswordExpires) Compliant" -BackgroundColor Green
    }
    else
    {
    Write-Host "Account Name: $($acc.Name) PasswordExpiry $($acc.PasswordExpires) Voilation" -BackgroundColor Red
    }
   
   }

   #Check CSFalconService service
   if(Get-Service  CSFalconService -ErrorAction Ignore|where {$_.Status -eq 'Running'}){Write-Host "CSFalconService Running Compliant" -BackgroundColor Green}else{Write-Host "CSFalconService Not Running Violation" -BackgroundColor Red}

   #%SystemRoot%
    GetFileReadStatus -File $env:windir
  # %SystemRoot%\security
     GetFileReadStatusNot -File $env:windir"\security"
  #%SystemRoot%\system
  GetFileReadStatus -File $env:windir"\system"
  #%SystemRoot%\system32
  GetFileReadStatus -File $env:windir"\system32"
  #%SystemRoot%\system32\config
  GetFileReadStatus -File $env:windir"\system32\config"
  #%SystemRoot%\system32\drivers
   GetFileReadStatus -File $env:windir"\system32\drivers"
   #%SystemRoot%\system32\spool
   GetFileReadStatus -File $env:windir"\system32\spool"
   #%SystemRoot%\system32\GroupPolicy
      GetFileReadStatus -File $env:windir"\system32\GroupPolicy"

   #%WinDir%\WinSxS\Backup
     GetFileReadStatus -File $env:windir"\WinSxS\Backup"

#%SystemRoot%\system32\winload.exe
GetFileReadStatus -File $env:windir"\system32\winload.exe"
#%SystemDrive%
GetFileReadStatus -File $env:HOMEDRIVE
#%SystemRoot%\syswow64
GetFileReadStatus -File $env:windir"\syswow64"
#%SystemRoot%\syswow64\drivers
GetFileReadStatus -File $env:windir"\syswow64\drivers" 

#%SystemRoot%\System32\Winevt\Logs\Security.evtx

GetFileReadStatusNot -File $env:windir"\System32\Winevt\Logs\Security.evtx"

#%SystemDrive%\boot\BCD
GetFileReadStatus -File $env:HOMEDRIVE"\boot\BCD"

#%SystemDrive%\bootmgr
GetFileReadStatus -File $env:HOMEDRIVE"\bootmgr"

#%SystemDrive%\AUTOEXEC.BAT
GetFileReadStatus -File $env:HOMEDRIVE"\AUTOEXEC.BAT"

#%SystemDrive%\CONFIG.SYS
GetFileReadStatus -File $env:HOMEDRIVE"\CONFIG.SYS"

#%SystemRoot%\System32\Winevt\Logs\DNS Server.evtx
GetFileReadStatusNot -File $env:HOMEDRIVE"\System32\Winevt\Logs\DNS Server.evtx"



if( (Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\Application).RestrictGuestAccess -eq 1)
{
write-host "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application Compliant" -BackgroundColor Green
}
else
{
Write-host "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application Violation" -BackgroundColor Red
}


if((Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\Security).RestrictGuestAccess -eq 1)
{
write-host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\Security Compliant" -BackgroundColor Green
}
else
{
Write-host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\Securit Violation" -BackgroundColor Red
}

if((Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\System).RestrictGuestAccess -eq 1)
{
write-host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\System Compliant" -BackgroundColor Green
}
else
{
Write-host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\System Violation" -BackgroundColor Red
}




  
   if( (get-acl HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog|select *).AccessToString.Contains("BUILTIN\Users"))
   {
   Write-Host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog Violation" -BackgroundColor Red
   }
   else
   {
   Write-Host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog Compliant" -BackgroundColor Green
   }

   #hkcr
   $hkcr=(get-acl Registry::hkcr|select AccessToString).AccessToString -join ''
   if (($hkcr).Contains("BUILTIN\Users Allow  ReadKey"))
   {
   Write-Host "HKCR Compliant" -BackgroundColor Green
   }
   else
   {
   Write-Host "HKCR Violation" -BackgroundColor Red
   }


   #DNS Server
   
   if( (get-acl HKLM:'\SYSTEM\CurrentControlSet\Services\Eventlog\DNS Server'|select *).AccessToString.Contains("BUILTIN\Users"))
   {
   Write-Host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\DNS Server Violation" -BackgroundColor Red
   }
   else
   {
   Write-Host "HKLM:\SYSTEM\CurrentControlSet\Services\Eventlog\DNS Server Compliant" -BackgroundColor Green
   }

   if((gwmi win32_useraccount -Filter "Name='Guest'"|select Disabled).Disabled)
   {
    write-host "Guest Disabled Compliant" -BackgroundColor Green
   }
   else
   {
    write-host "Guest Disabled Violation" -BackgroundColor Red

   }

   