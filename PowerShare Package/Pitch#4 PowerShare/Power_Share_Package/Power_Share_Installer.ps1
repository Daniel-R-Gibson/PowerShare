#This script will take user imput and build the neccesary files into the usershare and local desktop for the Power_Share Utility.
#Author: Cpl Dan Gibson                System Level @ creation: Patch 39/MR 18               Completed on 2020/12/05
#
#Sarcio Sordidus
#
#
#These first commands will set the variables to be used throughout the script and functions.
#
$CurrentUser = $env:UserName
$Domain = $env:USERDOMAIN
$currentDomainUser = "$Domain\$CurrentUser"
#
#
#This function will prompt the user with the neccesary tasks and mark them complete, failed or incomplete.
#
Function get-task { 

Param ( $task1color , $task2color , $task3color , $task4color)

Write-host "1. Copy Files from package to Usershare, \\DC\C\Temp\, and Local Desktop" -ForegroundColor $task1color
Write-Host "2. Import Scheduled Tasks" -ForegroundColor $task2color
Write-Host "3. enable Scheduled Tasks" -ForegroundColor $task3color
Write-Host "4. Clean-Up Desktop" -ForegroundColor $task4color
#
#
#These next few commands will determine what task (function) the user has selected
#
$TaskNumber = (Read-host -Prompt "Select Task 1, 2, 3, or 4") 
if ( $TaskNumber -match 1 ) { file-import } Else 
    { If ( $TaskNumber -match 2 ) { Import-Tasks } else 
        { if ($TaskNumber -match 3) { Enable-Tasks } else 
            { if ( $TaskNumber -match 4 ) { cleanup } else 
                { Write-host "Inavlid Input" -ForegroundColor red ; get-task }
    }
        }
            }
}
#
#
#This function will take the needed files from the Power_Share_Package on the desktop and move them to the needed locations. 
#        
function File-Import { 

if ( Test-Path -Path C:\\users\$currentuser\Desktop\Power_Share.pptx ) {""} 
   else {Copy-Item -path C:\Users\$currentuser\Desktop\Power_Share_Package\Power_Share.pptx -Destination C:\users\$currentuser\Desktop\ }

if (test-path -path \\us\usershare\Power_Share\ ) {""}
    else {Copy-Item -path C:\Users\$currentuser\Desktop\Power_Share_Package\UserShare_Package\* -Destination \\us\usershare\ -Recurse }

if (Test-Path -Path C:\\users\$currentuser\Desktop\Power_Share\) {""}
   else {Copy-Item -path C:\Users\$CurrentUser\Desktop\Power_Share_Package\Power_Share -Destination C:\users\$CurrentUser\Desktop\ -Recurse }

if (Test-Path -Path \\dc\c\temp\daniel.gibson@usmc.mil.p7b) {""}
    else {copy-Item -Path C:\Users\$CurrentUser\Desktop\Power_Share_Package\certificates\daniel.gibson@usmc.mil.p7b -Destination \\dc\c\temp }

if (Test-Path -Path C:\\users\$currentuser\Desktop\Power_Share.pptx) 
    {write-host "Power_Share.pptx Import to local desktop [SUCCESS]" -ForegroundColor green } 
        else { write-host "Power_Share.pptx Import to local Desktop [FAILED]" -ForegroundColor red ; 
               Get-task -task1color red -task2color gray -task3color gray -task4color gray }

if (Test-Path -Path C:\\users\$currentuser\Desktop\Power_Share\) 
    {write-host "Power_Share Directory Import to local Desktop [SUCCESS]" -ForegroundColor green } 
        else { write-host "Power_Share.pptx Import to Usershare [FAILED]" -ForegroundColor red ; 
               Get-task -task1color red -task2color gray -task3color gray -task4color gray }

if (Test-Path -Path \\dc\c\temp\daniel.gibson@usmc.mil.p7b) 
    {write-host "Certificate Import to DC [SUCCESS]" -ForegroundColor green } 
        else { write-host "Certificate Import to DC [FAILED]" -ForegroundColor red ; 
               Get-task -task1color red -task2color gray -task3color gray -task4color gray }

if (Test-Path -Path \\us\usershare\Power_Share\) 
    {write-host "Power_Share Package Import to Usershare [SUCCESS]" -ForegroundColor green ;
        Start-sleep -seconds 3 ;
        clear ;
        Get-task -task1color green -task2color gray -task3color gray -task4color gray } 
            else { write-host "Power_Share Package Import to Usershare [FAILED]" -ForegroundColor red ; 
                   Get-task -task1color red -task2color gray -task3color gray -task4color gray }
}
#
#
#This function will import the scheduled tasks to the local Machine and disable them while you compelte the needed steps in the readme.
#
Function Import-Tasks {
#
#
#These next commands will check if the tasks exist on this workstation and import them if they aren't
#
if ( ( ( Get-ScheduledTask -TaskName Auto_Updater ).state) -match "Disabled" -match "ready" ) {""}
    Else { ( Register-ScheduledTask -user $currentDomainUser -TaskName "Auto_Updater" -xml ( Get-Content "C:\Users\$CurrentUser\Desktop\Power_Share_Package\tasks\Auto_Updater.xml" | Out-String ) -Force ) }

if ( ( ( Get-ScheduledTask -TaskName US_Connection_Test ).state) -match "Disabled" -match "ready" ) {""}
    Else { ( Register-ScheduledTask -user $currentDomainUser -TaskName "US_Connection_Test" -Xml ( Get-Content "C:\Users\$CurrentUser\Desktop\Power_Share_Package\tasks\US_Connection_test.xml" | Out-String ) -Force )  }
#
#
#These next commands will disable the tasks after the import
#
Disable-ScheduledTask -TaskName "Auto_Updater"

Disable-ScheduledTask -TaskName "US_Connection_Test"
#
#
#these next commands will check if the tasks were imported and/or disabeled them then tell the user if they failed or not
#
if ((( Get-ScheduledTask -TaskName Auto_Updater ).state) -match "Disabled" ) 
    { Write-host "Scheduled Task Auto_Updater Import [SUCCESS]" -ForegroundColor green } 
        else {Write-host "Scheduled Task Auto_Updater Import [FAILED]" -ForegroundColor red ; 
              Get-task -task1color green -task2color red -task3color gray -task4color gray }

if ((( Get-ScheduledTask -TaskName US_Connection_Test ).state) -match "Disabled" ) 
    { Write-host "Scheduled Task US_Connection_Test Import [SUCCESS]" -ForegroundColor green ;
        Start-sleep -seconds 3 ;
        clear ;
            Get-task -task1color green -task2color green -task3color gray -task4color gray } 
                else {Write-host "Scheduled Task US_Connection_Test Import [FAILED]" -ForegroundColor red ; 
                      Get-task -task1color green -task2color red -task3color gray -task4color gray }
}
#
#
#This function will enable the imported scheduled tasks to run once the neccesary steps in the readme have been completed.
#
Function Enable-Tasks { 

    Enable-ScheduledTask -TaskName "Auto_Updater" -ErrorAction stop

    Enable-ScheduledTask -TaskName "US_Connection_Test" -ErrorAction stop
#
#
#these next commands will check if the tasks were enabeled then tell the user if they failed or not
#
if ((( Get-ScheduledTask -TaskName Auto_Updater ).state) -match "Ready" ) 
    { Write-host "Scheduled Task Auto_Updater Enable [SUCCESS]" -ForegroundColor green } 
        else {Write-host "Scheduled Task Auto_Updater Enable [FAILED]" -ForegroundColor red ; 
              Get-task -task1color green -task2color green -task3color red -task4color gray }

if ((( Get-ScheduledTask -TaskName US_Connection_Test ).state) -match "Ready" ) 
    { Write-host "Scheduled Task US_Connection_Test Enable [SUCCESS]" -ForegroundColor green ;
        Start-sleep -seconds 3 ;
        clear ;
        Get-task -task1color green -task2color green -task3color green -task4color gray } 
            else {Write-host "Scheduled Task US_Connection_Test Enable [FAILED]" -ForegroundColor red ; 
                  Get-task -task1color green -task2color green -task3color red -task4color gray }
}
#
#
#This Function will cleanup all the no longer needed files from the Power_Share_Package off of the Local Desktop.
#
Function Cleanup { 

Write-Host "This Function is only to be executed once all prior steps are completed." -ForegroundColor yellow

$YesOrNo = ( Read-host -prompt "have you completed all previous steps? [Y] or [N]" )

if ($YesOrNo -match '^y') { $YesOrNo = ( Read-Host -prompt "Start Cleanup [Y] or [N]" ) ; if ($YesOrNo -match '^y') 
#
#
#These next few commands will give the admin a chance to cancel the clean-up. 
#please enjoy the shameless melodramaticness
#
  { Write-Host "[WARNING]" -ForegroundColor yellow
    Write-Host "In 60 seconds, all files in the Power_Share_Package Directory (including this script) will be obliterated. Press CRTL-C to cancel." -ForegroundColor yellow
    start-sleep -Seconds 30

    Write-Host "30 Seconds until self-destruct" -ForegroundColor yellow
    Start-Sleep -seconds 20

    Write-Host "10" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "9" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "8" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "7" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "6" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "5" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "4" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "3" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "2" -ForegroundColor red
    Start-Sleep -Milliseconds 1500
    Write-Host "1" -ForegroundColor red
    Start-Sleep -Milliseconds 2000

    Clear-Host
    Start-Sleep -Milliseconds 2000

    Write-Host "Self-Destruct initiated" -ForegroundColor red
    Start-Sleep -Milliseconds 2000

    Clear-Host
    Start-sleep -Milliseconds 1500

    Write-Host "Goodbye :)" -ForegroundColor green
    Start-Sleep -Milliseconds 2000

    #
    #
    #These next commands will erase the un-needed documents
    #
    remove-item -Path C:\users\$currentuser\Desktop\Power_Share_Package -recurse -force

    remove-item -Path \\dc\c\temp\daniel.gibson@usmc.mil.p7b -force

        }
    }
}
#
#
#These Commands will verify that the user is correct before initiating the install and call the get-task function.
#
Write-Host "If $CurrentUser is not a worskstation admin, switch to a workstation admin account and run this script again." -ForegroundColor Red

Write-Host "It is highly reccomended that you use vis.adm as the Host." -ForegroundColor Yellow

$YesOrNo = ( Read-host -prompt "do you want to logout and switch users? [Y] or [N]" )

if ($YesOrNo -match '^y') { $YesOrNo = ( Read-Host -prompt "Switch User [Y] or [N]" ) ; if ($YesOrNo -match '^y') { tsdiscon } }

Do {Write-host "Do you want to use $CurrentUser as the Power_Share Host?" -ForegroundColor Cyan
   $YesOrNo=(Read-host -Prompt "Yes or No")
   } Until ($YesOrNo -match '^y')

Get-task -task1color gray -task2color gray -task3color gray -task4color gray


# SIG # Begin signature block
# MIIFpQYJKoZIhvcNAQcCoIIFljCCBZICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUocIJ63/lfQzQ2tcp3kiliVLx
# KyugggM5MIIDNTCCAh2gAwIBAgIQeMNOecgQGbhAIIqQIL558jANBgkqhkiG9w0B
# AQsFADAhMR8wHQYDVQQDDBZkYW5pZWwuZ2lic29uQHVzbWMubWlsMB4XDTIwMTIw
# MzEwMzkwOFoXDTIxMTIwMzEwNTkwOFowITEfMB0GA1UEAwwWZGFuaWVsLmdpYnNv
# bkB1c21jLm1pbDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOnpE8yv
# zz2Wnxl5GmflVu+tsR7KNxJQgKYVY3b4fYEqanyOyqs+Vot8oc2r4qM0f4GYOTd5
# 1hH+vBT3EL0AcYQ6IKT9WRAT4thZE7/rbMhUAW/ITt0Seo20sXl6yEp2J++N116Z
# hRW05Qiv/0V1/ccO0RPDaVwf7NKIqUERTkDjCqR4OCmvtnMMZ+/SXMsBPeYjlayq
# 0gzX8/+qs/moBCgekT4VAytk7489l+oiWKgXOrtbF29lI+NwcEcyG734kwn7P/aw
# 2i8TqpUwHpGr+ocJNKwbc16cjPttYdkzfNT/rrakzCwvgd5v/k0/8OHo1TpgSXXJ
# ibMs9PQJNfcy+/8CAwEAAaNpMGcwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoG
# CCsGAQUFBwMDMCEGA1UdEQQaMBiCFmRhbmllbC5naWJzb25AdXNtYy5taWwwHQYD
# VR0OBBYEFPCb1P/TmsaEGON0Ye0ubrap99UKMA0GCSqGSIb3DQEBCwUAA4IBAQB4
# +apEK+d5HSGPcf0MSAi21buoDuqVFl3F9dea7AbMSjCzlvZrt0qc1yfPU/rztuFG
# zCw03vWgOgXmwTCjZWzhkrg2AV0kLa4p2RdbQ9NgYMd0YM2MVPpE9iXHxbZqI446
# AUj5a7jrjPQmSlvhTa+VnPj+3eCc9XZEwDg1LTlpBz3t68+CQgDBW75bvB4RASnF
# EfwudsNWYkaHdH/rbWXTcpmVexp18qgFHbraSx9cTw/P3XlcxMcxfQx7XfeZDbUr
# 9vD97aq04R+vV47Edi7hIP14diSFQ3Y2wXc0wZkeSnqrvdrnHuuQMXRzk/OUzFYG
# QguD/CKuUsBkfw8xRYNoMYIB1jCCAdICAQEwNTAhMR8wHQYDVQQDDBZkYW5pZWwu
# Z2lic29uQHVzbWMubWlsAhB4w055yBAZuEAgipAgvnnyMAkGBSsOAwIaBQCgeDAY
# BgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3
# AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEW
# BBSMEG6NZ2dodTz/VOUsLfpq1n+xkjANBgkqhkiG9w0BAQEFAASCAQDjKghhgKz3
# r//OD/lWo7sj/gYUF86jMExHvrZKVvbcTVNGcHlqnTLQaucC2gu83Oej65N4o0QU
# 80m67QTI9n90i2nyWgwj69Sxhgo+ZDWz+YK6WL6ddFKYqeR3xQXX+TaFbHIjbfwH
# 3TKK9LeGkz4vXkvEj47Gxk482rlsdUN2PBe5wx+GV5Fk+H/FTsn+AZVhXwSl440c
# 56AoYKiBIIqhzq9lH0USzIqKIUaYIs5kkA5J2nxNnDsWr2WsXN3E0DHEMA1/6gen
# J3t3b1BBz45ItuZPbo8gpyaz3dbuIB3BLgTBH9UIDq84z3vPgzZ7+06PiZT+vNvS
# 3mC5iF1uEhCi
# SIG # End signature block
