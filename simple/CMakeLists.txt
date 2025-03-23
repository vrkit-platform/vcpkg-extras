add_executable(simple main.cpp)
target_link_libraries(simple PRIVATE fmt::fmt ${sdkTarget})

# add_executable(simple_dynamic main.cpp)
# target_link_libraries(simple_dynamic PRIVATE fmt::fmt irsdkcpp::irsdkcpp_shared)

# string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" IRSDKCPP_BUILD_STATIC)
# if (IRSDKCPP_BUILD_STATIC)
# target_link_libraries(simple PRIVATE fmt::fmt irsdkcpp::irsdkcpp_static)
# else() 
# target_link_libraries(simple PRIVATE fmt::fmt irsdkcpp::irsdkcpp)
# endif()
