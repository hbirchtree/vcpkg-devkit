vcpkg_download_distfile(ARCHIVE
    URLS https://github.com/devkitPro/libogc/archive/refs/tags/v3.1.0.tar.gz
    FILENAME ${PORT}.tar.gz
    SHA512 e484fdb27ed73d703302fc0f78abd9a1eaf18291399764ac9b4c747815e2f8e8396923a889a16ba032087886d093fd3be88c4e91285ad7fc062f0cba8395c577
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
