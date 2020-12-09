#This script will automatically update the power_share.pptx (and all linked documents) whenever a change is monitored on the usershare\Power_Share\ directory
#Author: Cpl Dan Gibson                System Level @ creation: Patch 39/MR 18               Completed on 2020/12/04
#
#Sarcio Sordidus
#
#This function will be called by the check-file function whenever a change is identified on the files that the check-file function is monitoring.
#
function update-powershare {
        write-host "updating... please wait" -ForegroundColor yellow
        #
        #
        #These Commands will close the local copy of the Power_Share.pptx so that we can remove the local copy and replace it with the updated usershare copy
        #
        $CurrentUser = $env:UserName
        Stop-Process -Name "POWERPNT"
        Start-Sleep -Seconds 3
        Remove-Item "C:\Users\$CurrentUser\Desktop\Power_Share.pptx"
        Copy-Item -Path "\\us\usershare\Power_Share\Power_Share.pptx" -Destination "C:\Users\$CurrentUser\Desktop\"
        Start-sleep -seconds 5
        #
        #
        #These commands will open the new locally saved copy, update the links, save it, and bring it into full-screen.
        #
        invoke-item -path "C:\Users\$CurrentUser\Desktop\Power_Share.pptx"
        [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
        [System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")
        [Microsoft.VisualBasic.Interaction]::AppActivate
        Start-Sleep -Seconds 2
        [System.Windows.Forms.SendKeys]::SendWait("{Tab}")
        [System.Windows.Forms.SendKeys]::SendWait("{Tab}")
        [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
        [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
        [System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")
        [Microsoft.VisualBasic.Interaction]::AppActivate
        Start-Sleep -Seconds 2
        [System.Windows.Forms.SendKeys]::SendWait('^s')
        start-sleep -seconds 1
        [System.Windows.Forms.SendKeys]::SendWait("{F5}")
        }
#
#
#This function will continually check the usershare for mmodifications to the documents listed in ((((Get-ItemProperty -Path '\\us\usershare\Power_Share\
#This is done by pulling the last moditication time/date of the document and comparing it to the current date/time.
#If you intend on adding a document to this function, copy lines 49, 50, and 51 and then change the path to reflect the document you want to monitor.
#
function check-file { 
       #
       #
       #This command gets the current date and time to compare against the power_Share directory in the next commands
       #
       ( $hourminute = (Get-Date).tostring("yyyyMMddhhmmss")) 
       start-sleep -Seconds 3
       #
       #
       #This command checks for a file modification and calls the update-powershare function if a change is detected in the last 3 seconds
       #
       if ((((Get-ItemProperty -Path \\us\usershare\Power_Share\ ).LastWriteTime).tostring("yyyyMMddhhmmss") -gt $hourminute)) 
       { update-powershare 
       }
        #
        # 
        #This command clears the last output to prevent output overflow       
        #
        clear
        #
        #
        #this last command will ensure that the monitoring of the documents continues after a change has been logged and the update-powershare function was called.
        #
        check-file
       } 
#
#
#This command initiates the loop created in the check-file function by calling the function for the first time
#
check-file
#
#
#This next bit is the hash for the self-signed certificate
#      


# SIG # Begin signature block
# MIIFpQYJKoZIhvcNAQcCoIIFljCCBZICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUpJlSyxArk/It4o7GkJcOBJZv
# BV2gggM5MIIDNTCCAh2gAwIBAgIQeMNOecgQGbhAIIqQIL558jANBgkqhkiG9w0B
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
# BBTkJiQMt2NJGRvBshYTv4FmmRTuODANBgkqhkiG9w0BAQEFAASCAQBMvfaE/E3K
# /+OQPzkAN6PA0JsZcKDouN0GVEycs23AFn49Fs7U2vbFAEQGM6BCQs5LJBi7CfgM
# MV98noMPYoWWlQ4prAZ4nxJ3jFp3Si+ZRvQNfjJYJOIXfYE4wVecvmOLlmRg1PbH
# ZikvnxXKr59OHKLgX2Vl6Z5xePainqjYzkNeKp6D+JtkzlN94wA8JqcWnw9QTbF+
# vuWMlrg4Zr/0xKFjwdjnAuV0KZuREQ01xTO7wMK351GCkESxnVPqKcFUWXgCgdE4
# BO3S76SQqKl7gnoahbcdGxO6YAvBWXg/wbdExfhioh2hM06DlDCNNS2rRJbjI0Bd
# cjYxLhyYTLSM
# SIG # End signature block
