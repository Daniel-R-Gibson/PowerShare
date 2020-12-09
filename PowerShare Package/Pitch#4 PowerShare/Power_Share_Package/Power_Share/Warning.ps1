#This Script checks the connection to the usershare (to ensure that the Power_Share.pptx can pull from the files needed) 
#If the connection to the usershare is broken, the script will open a warning in powerpoint. 
##Author: Cpl Dan Gibson                System Level @ creation: Patch 39/MR 18               Completed on 2020/12/04
#
#Sarcio Sordidus
#
#
$CurrentUser = $env:UserName
function us-check { if ( test-path \\us\usershare\ ) 
{ ( $hourminute = (Get-Date).tostring("hh:mm")) 
clear
start-sleep -Milliseconds 200
write-host "last successfull check at $hourminute" -ForegroundColor green
start-sleep -Seconds 10
us-check
    } 
else { (invoke-item -path C:\users\$CurrentUser\Desktop\Power_Share\warning.pptx )
       [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
       [System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")
       [Microsoft.VisualBasic.Interaction]::AppActivate
       start-sleep -seconds 1
       [System.Windows.Forms.SendKeys]::SendWait("{F5}")
       clear
       start-sleep -Milliseconds 200
       write-host "last successfull check at $hourminute" -ForegroundColor red 
       read-host -Prompt "hit [ENTER] once connectivity has been restored"
       us-check 
    }
}
us-check


# SIG # Begin signature block
# MIIFpQYJKoZIhvcNAQcCoIIFljCCBZICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQULc21M3cGRqjSSMqANkv9AVK0
# evKgggM5MIIDNTCCAh2gAwIBAgIQeMNOecgQGbhAIIqQIL558jANBgkqhkiG9w0B
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
# BBSNLdcF9iHHeNjk1KED7k0TTuedkTANBgkqhkiG9w0BAQEFAASCAQB6vgEA462D
# LISjYlkiPbhO9p6dSJDIc2z66fSoqJlHdifPW3Ff7ZcydP4kMEAf7WWat7xr/wRQ
# cckDjlZudoN7kqHm0779EG85Heg4SFF2N0uw5JMMdUodG1N6TzqRgmvN4LkrXfax
# BVk3ko/XRi7VnaJNwStT2q/LsQ/+fbkgt4bDY19OOyuypkBfxB5wtrfEohoI0aAi
# MKEk+CzheRhIyXbYpSCC3q9xeWNidT4x+x/+4pL/toKwMo4eoJp+8EQp6UOIYRSt
# 0tUGGF4HuIKHlhIHltKCY/IMmHKB38KSnJ5nWR+5cP1mGaGuJJ6BD4kjJ5EHvMTG
# i/G8dmjGq7vE
# SIG # End signature block
