. .psenvrc.ps1

$regPath = "$PSScriptRoot\..\vcpkg"
$regForkPath = "$PSScriptRoot\..\vcpkg-vrkit-platform"
$overlaysPath = "$PSScriptRoot\..\vcpkg-vrkit-platform-overlays"
$buildPath = "$PSScriptRoot\build"

Remove-Item $regPath\downloads\vrkit*
Copy-Item -Recurse "$regForkPath\ports\irsdkcpp\*" "$overlaysPath\irsdkcpp\"


if (Test-Path $buildPath) {
  Remove-Item -Recurse -Force $buildPath
}

cmake -B build/debug-static -S . `
  -DVCPKG_TARGET_TRIPLET=x64-windows-static `
  -DCMAKE_BUILD_TYPE=Debug `
  -DCMAKE_TOOLCHAIN_FILE="$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
cmake --build .\build\debug-static --target simple

cmake -B build/debug-dynamic -S . `
  -DVCPKG_TARGET_TRIPLET=x64-windows `
  -DIRSDKCPP_EXAMPLE_LINK_SHARED=ON `
  -DCMAKE_BUILD_TYPE=Debug `
  -DCMAKE_TOOLCHAIN_FILE="$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"

cmake --build .\build\debug-dynamic --target simple