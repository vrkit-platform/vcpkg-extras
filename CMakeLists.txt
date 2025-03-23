cmake_minimum_required(VERSION 3.10)
if(POLICY CMP0091)
  cmake_policy(SET CMP0091 NEW)
endif()

project(vcpkg-vrkit-platform-examples)

set(CMAKE_CXX_STANDARD 23)

option(IRSDKCPP_EXAMPLE_LINK_SHARED "Should link to DLL instead of static" OFF)

cmake_dependent_option(IRSDKCPP_MSVC_SHARED_RT
  "MSVC: Build irsdkcpp with shared runtime libs (/MD)" ON
  "CMAKE_SYSTEM_NAME MATCHES Windows" OFF)
  
if (IRSDKCPP_EXAMPLE_LINK_SHARED)
  set(sdkTarget irsdkcpp::irsdkcpp_shared)
  set(IRSDKCPP_EXAMPLE_LINK_STATIC OFF)
else()
  set(sdkTarget irsdkcpp::irsdkcpp_static)
  set(IRSDKCPP_EXAMPLE_LINK_STATIC ON)
endif()
  
set(buildShared $<BOOL:${IRSDKCPP_EXAMPLE_LINK_SHARED}>)
set(buildWindowsDLL $<AND:$<BOOL:${CMAKE_HOST_WIN32}>,${buildShared}>)
set(isMSVCSharedRT $<BOOL:${IRSDKCPP_MSVC_SHARED_RT}>)

if (NOT DEFINED CMAKE_MSVC_RUNTIME_LIBRARY)
  if (IRSDKCPP_EXAMPLE_LINK_STATIC)
    set(CMAKE_MSVC_RUNTIME_LIBRARY
      MultiThreaded$<$<CONFIG:Debug>:Debug>)
  else()
    set(CMAKE_MSVC_RUNTIME_LIBRARY
      MultiThreaded$<$<CONFIG:Debug>:Debug>$<${isMSVCSharedRT}:DLL>)
  endif()
endif()
  
find_package(fmt CONFIG REQUIRED)
find_package(irsdkcpp CONFIG REQUIRED)

add_subdirectory(simple)