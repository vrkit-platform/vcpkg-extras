# iRacing C++ SDK Integration Tools & Examples for [VCPKG](https://github.com/microsoft/vcpkg)

This repo contains tools, scripts & examples used to maintain the [VCPKG](https://github.com/microsoft/vcpkg) `portfile.cmake` & other configuration required for integration with [VCPKG](https://github.com/microsoft/vcpkg)

## Scripts

Run the VCPKG for `dynamic` or `static` targets.

```powershell

# Run both static & dynamic
& .\run-vcpkg-build.ps1

# Test with static linkage
& .\run-vcpkg-build.ps1 -static

# Test with dynamic linkage
& .\run-vcpkg-build.ps1 -dynamic

# Test with UWP NOT CURRENTLY SUPPORTED
& .\run-vcpkg-build.ps1 -uwp

```