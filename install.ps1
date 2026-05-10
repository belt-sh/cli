$ErrorActionPreference = "Stop"

$Version = if ($env:VERSION) { $env:VERSION } else { "latest" }
$Arch = "amd64"
$DistBase = "https://dist.inference.sh/cli"

# resolve download url
if ($Version -eq "latest") {
    $Manifest = Invoke-RestMethod "$DistBase/manifest.json"
    $Build = $Manifest.builds."windows-$Arch"
    $Url = $Build.url
    $ExpectedHash = $Build.sha256
} else {
    $Url = "$DistBase/inferencesh-cli-$Version-windows-$Arch.zip"
    $ExpectedHash = $null
}

$InstallDir = if ($env:INSTALL_DIR) { $env:INSTALL_DIR } else { "$env:LOCALAPPDATA\belt" }
$TmpDir = Join-Path $env:TEMP "belt-install-$(Get-Random)"

New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
New-Item -ItemType Directory -Force -Path $TmpDir | Out-Null

$ZipName = Split-Path $Url -Leaf
$ZipPath = Join-Path $TmpDir $ZipName

Write-Host "downloading belt $Version for windows-$Arch..."
Invoke-WebRequest -Uri $Url -OutFile $ZipPath

# verify checksum
if ($ExpectedHash) {
    Write-Host "verifying checksum..."
    $ActualHash = (Get-FileHash $ZipPath -Algorithm SHA256).Hash.ToLower()
    if ($ActualHash -ne $ExpectedHash) {
        Write-Error "checksum mismatch! expected: $ExpectedHash got: $ActualHash"
        exit 1
    }
    Write-Host "checksum verified."
}

Expand-Archive -Path $ZipPath -DestinationPath $TmpDir -Force

$Binary = Get-ChildItem -Path $TmpDir -Filter "inferencesh-cli-*.exe" | Select-Object -First 1
$TargetPath = Join-Path $InstallDir "belt.exe"

Move-Item -Path $Binary.FullName -Destination $TargetPath -Force

# add to PATH if not already there
$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($UserPath -notlike "*$InstallDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$UserPath;$InstallDir", "User")
    $env:Path = "$env:Path;$InstallDir"
    Write-Host "added $InstallDir to PATH"
}

Remove-Item -Recurse -Force $TmpDir

Write-Host "installed to $TargetPath"
Write-Host "run 'belt' to get started"
