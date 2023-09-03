$TimeZone = [System.TimeZoneInfo]::FindSystemTimeZoneById("China Standard Time")
$Tag = [System.TimeZoneInfo]::ConvertTime($(Get-Item assets/tmpchinesefont).LastWriteTime, $TimeZone).ToString("yyMMdd")
echo "MY_TAG=$Tag" | Out-File -FilePath $env:GITHUB_ENV -Append
$Path = "Release"
New-Item -Name "$Path" -ItemType "directory" -Force
New-Item -Path "$Path" -Name "BepInEx" -ItemType "directory" -Force
New-Item -Path "$Path/BepInEx" -Name "plugins" -ItemType "directory" -Force
New-Item -Path "$Path/BepInEx/plugins" -Name "LLC" -ItemType "directory" -Force
$BIE_LLC_Path = "$Path/BepInEx/plugins/LLC"
Copy-Item -Path assets/tmpchinesefont $BIE_LLC_Path -Force
Set-Location "$Path"
7z a -t7z "./tmpchinesefont_BIE_$Tag.7z" "BepInEx/" -mx=9 -ms
Set-Location "../"