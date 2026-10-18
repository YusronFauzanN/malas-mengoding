# PowerShell 1-Line Installer for Forge AI
$ErrorActionPreference = 'Stop'

$Repo = "YusronFauzanN/malas-mengoding"
$InstallDir = "$env:LOCALAPPDATA\Programs\forge"
$ZipFile = "$env:TEMP\forge-windows-x86_64.zip"
$DownloadUrl = "https://github.com/$Repo/releases/latest/download/forge-windows-x86_64.zip"

Write-Host "Mengunduh Forge AI dari $DownloadUrl..." -ForegroundColor Cyan
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipFile -UseBasicParsing

Write-Host "Mengekstrak ke $InstallDir..." -ForegroundColor Cyan
if (!(Test-Path -Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}
Expand-Archive -Path $ZipFile -DestinationPath $InstallDir -Force
Remove-Item -Path $ZipFile -Force

# Tambahkan ke User PATH jika belum ada
$UserPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User)
if ($UserPath -notlike "*$InstallDir*") {
    Write-Host "Menambahkan $InstallDir ke PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("Path", "$UserPath;$InstallDir", [EnvironmentVariableTarget]::User)
    $env:Path += ";$InstallDir"
}

Write-Host "Instalasi Berhasil!" -ForegroundColor Green
Write-Host "Jalankan perintah 'forge' di PowerShell atau Terminal baru Anda." -ForegroundColor Green
