cmake_minimum_required(VERSION 3.0)
project(gctools LANGUAGES C CXX)

find_package(freeimage CONFIG REQUIRED )

add_definitions(
  -DPACKAGE_VERSION="1.0.6"
)

add_executable(gcdsptool
  gdopcode/assemble.cpp
  gdopcode/disassemble.cpp
  gdopcode/opcodes.cpp
  gdtool/gdtool.cpp
)
target_include_directories(gcdsptool PRIVATE
  gdtool/
  gdopcode/
)

add_executable(gxtexconv
  gxtool/converter.cpp
  gxtool/gxtexconv.cpp
  gxtool/image.cpp
  gxtool/parser.cpp
  gxtool/texturefile.cpp
  gxtool/tfbinary.cpp
  gxtool/tfbinarytdf.cpp
  gxtool/tokenstring.cpp

  dxtn/source/dxtn_compress.c
  dxtn/source/dxtn_fetch.c

  squish/source/alpha.cpp
  squish/source/clusterfit.cpp
  squish/source/colourblock.cpp
  squish/source/colourfit.cpp
  squish/source/colourset.cpp
  squish/source/maths.cpp
  squish/source/rangefit.cpp
  squish/source/singlecolourfit.cpp
  squish/source/squish.cpp
)
target_include_directories(gxtexconv PRIVATE
  gxtool/
  dxtn/source/
  squish/source/
)
target_link_libraries(gxtexconv PRIVATE
  freeimage::FreeImage
)

add_executable(elf2dol
  elftool/elf2dol.c
)

install(
  TARGETS
    gcdsptool
    gxtexconv
    elf2dol
  EXPORT gctools
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
install(
  TARGETS 
    gcdsptool
    gxtexconv
    elf2dol
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/gctoolsConfigVersion.cmake
  VERSION 1.0.6
  COMPATIBILITY SameMinorVersion
)

export(
  EXPORT gctools
  FILE ${CMAKE_CURRENT_BINARY_DIR}/gctoolsTargets.cmake
  NAMESPACE gctools::
)
install(
  EXPORT gctools
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/gctools
)
install(
  EXPORT gctools
  FILE gctoolsTargets.cmake
  NAMESPACE gctools::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/gctools
)
install(
  FILES
    gctoolsConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/gctoolsConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/gctools
)
