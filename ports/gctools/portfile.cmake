vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/devkitPro/gamecube-tools/archive/refs/tags/v1.0.6.zip
    FILENAME ${PORT}.tar.gz
    SHA512 fcdec051b636caef8cc66f619d10efc21a3eddc83c58625040854ccea1edc88ce6087685b5f7af95ee1c07fd7773276900b7699bd6eb470a3d7e16951e77057d
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

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
