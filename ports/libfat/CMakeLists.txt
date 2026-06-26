cmake_minimum_required(VERSION 3.13)
project(libfat LANGUAGES C)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# libfat uses libogc headers (disc_io, gctypes, sdcard/usbstorage drivers).
find_package(libogc CONFIG REQUIRED)

# Version header (upstream generates this; produce it directly).
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/include/libfatversion.h
"#ifndef __LIBFATVERSION_H__
#define __LIBFATVERSION_H__

#define _LIBFAT_MAJOR_ 1
#define _LIBFAT_MINOR_ 1
#define _LIBFAT_PATCH_ 5

#define _LIBFAT_STRING \"libFAT Release 1.1.5\"

#endif // __LIBFATVERSION_H__
")

add_library(libfat STATIC
    source/cache.c
    source/directory.c
    source/disc.c
    source/fatdir.c
    source/fatfile.c
    source/file_allocation_table.c
    source/filetime.c
    source/libfat.c
    source/lock.c
    source/partition.c
)
set_target_properties(libfat PROPERTIES OUTPUT_NAME fat)
target_include_directories(libfat
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/source
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_BINARY_DIR}/include
    INTERFACE
        $<INSTALL_INTERFACE:include>
)
target_link_libraries(libfat PUBLIC libogc::libogc)

install(
    TARGETS libfat
    EXPORT libfat
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(
    FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/include/fat.h
        ${CMAKE_CURRENT_BINARY_DIR}/include/libfatversion.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/libfatConfigVersion.cmake
    VERSION 1.1.5
    COMPATIBILITY SameMinorVersion
)
install(
    EXPORT libfat
    FILE libfatTargets.cmake
    NAMESPACE libfat::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libfat
)
install(
    FILES
        libfatConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/libfatConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libfat
)
