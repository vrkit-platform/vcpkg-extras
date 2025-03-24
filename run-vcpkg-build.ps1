param (
    [switch]$static = $false,
    [switch]$dynamic = $false,
    [switch]$uwp = $false
)


$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest
$PSNativeCommandUseErrorActionPreference = $true # might be true by default

if (!$static -and !$dynamic) {
  Write-Output "Enabling static AND dynamic"
  $static = $true
  $dynamic = $true
}

Write-Output "Building static=$static"
Write-Output "Building dynamic=$dynamic"
Write-Output "Building uwp=$uwp"

. .psenvrc.ps1

# $regPath = "$PSScriptRoot\..\vcpkg"
$regForkPath = "$env:VCPKG_ROOT"
if (-Not (Test-Path $regForkPath)) {
  Write-Output "VCPKG_ROOT not found at $regForkPath"
  exit 1
}

$overlaysPath = "$PSScriptRoot\overlays"
$overlayPortPath = "$overlaysPath\ports\irsdkcpp"
$overlayPortTargetPath = "$regForkPath\ports\irsdkcpp" 

$buildPath = "$PSScriptRoot\build"

Remove-Item $regForkPath\downloads\vrkit*

if (-Not (Test-Path $overlayPortTargetPath)) {
  mkdir $overlayPortTargetPath
}

Copy-Item -Recurse "$overlayPortPath\*" "$overlayPortTargetPath\" 

if (Test-Path $buildPath) {
  Remove-Item -Recurse -Force $buildPath
}

$TextInfo = (Get-Culture).TextInfo

function Build-Target($archType, $targetType, $buildType = "debug") {
  $buildTypeArg = $TextInfo.ToTitleCase($buildType)
  $targetTriple = $archType + "-" + $targetType
  $targetDir = $buildPath + "\" + $buildType + "-" + $targetTriple
  $linkSharedArg = If ($static) { "OFF" } else { "ON" }

  Write-Output "Target ($targetTriple)"
  Write-Output "Build type ($buildType)"
  Write-Output "Using directory ($targetDir)"
  
  cmake -B "$targetDir" -S . `
    -DVCPKG_TARGET_TRIPLET="$targetTriple" `
    -DCMAKE_BUILD_TYPE="$buildTypeArg" `
    -DCMAKE_TOOLCHAIN_FILE="$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" `
    -DIRSDKCPP_EXAMPLE_LINK_SHARED="$linkSharedArg"
  
  cmake --build "$targetDir" --target simple

}

if ($static) {
  Build-Target "x64" "windows-static"
}

if ($dynamic) {
  Build-Target "x64" "windows"
}

if ($uwp) {
  Build-Target "x64" "uwp"
}
