vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/devkitPro/libfat/archive/refs/tags/v1.1.5.tar.gz
    FILENAME ${PORT}.tar.gz
    SHA512 f3d32d03687d60c6c59cf3af78cd901aab15b1c802483cdaef47a5df477cc210817807d42293bbd427f856fc0b6901131cbb8ad2da1f9c66d58264b2217d17af
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/${PORT}Config.cmake DESTINATION ${SOURCE_PATH})

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
    "libfat - Copyright (c) 2008 Michael \"Chishm\" Chisholm, devkitPro.\n"
    "Distributed under the BSD license; full text in the source file headers.\n")

