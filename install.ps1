$Repo = "alirehmani/sureshift-dist"
$App = "sureshift"
$Version = "latest"

$Url = "https://github.com/$Repo/releases/$Version/download/sureshift-windows-x64.zip"

$Temp = New-Item -ItemType Directory -Force -Path "$env:TEMP\sureshift"

Invoke-WebRequest -Uri $Url -OutFile "$($Temp.FullName)\sureshift.zip"

Expand-Archive "$($Temp.FullName)\sureshift.zip" -DestinationPath "$($Temp.FullName)\bin"

$Target = "$env:LOCALAPPDATA\Programs\SureShift"
New-Item -ItemType Directory -Force -Path $Target

Copy-Item "$($Temp.FullName)\bin\sureshift.exe" $Target -Force

$envPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($envPath -notlike "*$Target*") {
[Environment]::SetEnvironmentVariable(
"Path",
"$envPath;$Target",
"User"
)
}

Write-Host "SureShift installed. Restart terminal."
