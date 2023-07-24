vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/devkitPro/libogc/archive/refs/tags/v2.4.1.tar.gz
    FILENAME ${PORT}.tar.gz
    SHA512 120615fd2af1a439160f3a6e9ce5b7f093911429f7124cb40533edaa520902f26c7ffffbbf1348b7009bb93b3975de960ee6d432863a6e293c60a0e9317c4816
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

file(INSTALL ${SOURCE_PATH}/libogc_license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
