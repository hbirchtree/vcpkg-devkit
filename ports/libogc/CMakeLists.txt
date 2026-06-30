cmake_minimum_required(VERSION 3.13)
project(libogc LANGUAGES C ASM)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# ---------------------------------------------------------------------------
# Version header (upstream generates this from libversion.h.in via Catnip; we
# build outside that environment, so produce it directly).
# ---------------------------------------------------------------------------
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/include/libversion.h
"#ifndef __LIBVERSION_H__
#define __LIBVERSION_H__

#define _V_MAJOR_ 3
#define _V_MINOR_ 1
#define _V_PATCH_ 0

#define _V_DATE_ __DATE__
#define _V_TIME_ __TIME__

#define _V_STRING \"libOGC Release 'v3.1.0'\"

#endif // __LIBVERSION_H__
")

# Shared include dirs (mirrors upstream libogc_inc INTERFACE).
set(LIBOGC_INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}/gc
    ${CMAKE_CURRENT_SOURCE_DIR}/libdb
    ${CMAKE_CURRENT_SOURCE_DIR}/libogc
    ${CMAKE_CURRENT_SOURCE_DIR}/tuxedo
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/netif
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/ipv4
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/ogc
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/ogc/machine
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/modplay
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/bte
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/sdcard
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/wiiuse
    ${CMAKE_CURRENT_SOURCE_DIR}/gc/di
    ${CMAKE_CURRENT_SOURCE_DIR}/external/bsd/include
    ${CMAKE_CURRENT_BINARY_DIR}/include
)

# libogc is built with optimisation upstream; several headers use
# __attribute__((always_inline)) which the compiler rejects at -O0, so force
# -O2 here regardless of the (debug) build type. -msdata=eabi matches the crt0
# SDA setup.
#
# -fomit-frame-pointer is REQUIRED, not just an optimisation: the consuming
# project injects -fno-omit-frame-pointer globally (for stacktraces). Forcing
# r31 as a frame pointer in the tuxedo exception/IRQ handlers corrupts the
# runtime -> IRQ panic loop on first interrupt. devkitPro builds libogc with
# the frame pointer omitted; we must match. This flag comes last so it wins
# over the global -fno-omit-frame-pointer.
set(LIBOGC_OPTS
    -O2
    -msdata=eabi
    -fno-strict-aliasing
    -Wno-array-bounds
    -Wno-stringop-overflow
    -Wno-stringop-overread
    -fomit-frame-pointer
)

# ---------------------------------------------------------------------------
# libogc - kernel/runtime (tuxedo) + core. Explicit source lists transcribed
# from the upstream tuxedo/ and libogc/ CMakeLists.txt (v3.1.0).
# ---------------------------------------------------------------------------
add_library(libogc STATIC
    # tuxedo - crt0, exceptions, threads, newlib syscalls
    tuxedo/common_crt0.S
    tuxedo/early_init.S
    tuxedo/default_stacks.c
    tuxedo/cache.c
    tuxedo/exception.c
    tuxedo/exception_asm.S
    tuxedo/interrupt.c
    tuxedo/interrupt_asm.S
    tuxedo/thread.c
    tuxedo/sync.c
    tuxedo/tick.c
    tuxedo/mailbox.c
    tuxedo/newlib_syscalls.c

    # libogc - LWP compatibility shims
    libogc/lwpcompat/lwpc_alarm.c
    libogc/lwpcompat/lwpc_queue.c
    libogc/lwpcompat/lwpc_thread.c
    libogc/lwpcompat/lwpc_sync.c
    libogc/lwpcompat/lwpc_sem.c
    libogc/lwpcompat/lwpc_mq.c

    # libogc - BSD sockets over lwIP
    libogc/ogc_sockets/soc_init.c
    libogc/ogc_sockets/soc_util.c
    libogc/ogc_sockets/soc_common.c
    libogc/ogc_sockets/soc_socket.c
    libogc/ogc_sockets/soc_bind.c
    libogc/ogc_sockets/soc_listen.c
    libogc/ogc_sockets/soc_send.c
    libogc/ogc_sockets/soc_recv.c
    libogc/ogc_sockets/soc_connect.c
    libogc/ogc_sockets/soc_shutdown.c
    libogc/ogc_sockets/soc_accept.c
    libogc/ogc_sockets/soc_poll.c
    libogc/ogc_sockets/soc_getsockname.c
    libogc/ogc_sockets/soc_fcntl.c
    libogc/ogc_sockets/soc_getsockopt.c
    libogc/ogc_sockets/soc_setsockopt.c
    libogc/ogc_sockets/soc_gethostbyname.c

    # libogc - core
    libogc/console.c
    libogc/lwp_queue.c
    libogc/lwp_wkspace.c
    libogc/lwp_heap.c
    libogc/video.c
    libogc/pad.c
    libogc/dvd.c
    libogc/exi.c
    libogc/arqueue.c
    libogc/arqmgr.c
    libogc/cache_asm.S
    libogc/system.c
    libogc/gx.c
    libogc/gu.c
    libogc/gu_psasm.S
    libogc/gu_ps_concat44.S
    libogc/audio.c
    libogc/cache.c
    libogc/card.c
    libogc/aram.c
    libogc/depackrnc.S
    libogc/depackrnc1.c
    libogc/dsp.c
    libogc/si.c
    libogc/tpl.c
    libogc/ipc.c
    libogc/console_font_8x16.c
    libogc/timesupp.c
    libogc/usbgecko.c
    libogc/usbmouse.c
    libogc/sbrk.c
    libogc/kprintf.c
    libogc/stm.c
    libogc/aes.c
    libogc/sha.c
    libogc/ios.c
    libogc/es.c
    libogc/isfs.c
    libogc/usb.c
    libogc/network_common.c
    libogc/sdgecko_io.c
    libogc/sdgecko_buf.c
    libogc/gcsd.c
    libogc/argv.c
    libogc/network_wii.c
    libogc/wiisd.c
    libogc/conf.c
    libogc/usbstorage.c
    libogc/texconv.c
    libogc/wiilaunch.c
    libogc/wd.c
    libogc/sys_report.c
    libogc/default_panic.c
)

set_target_properties(libogc PROPERTIES OUTPUT_NAME ogc)
target_include_directories(libogc PRIVATE ${LIBOGC_INCLUDES} INTERFACE $<INSTALL_INTERFACE:include>)
target_compile_options(libogc PRIVATE ${LIBOGC_OPTS})

# ---------------------------------------------------------------------------
# tinysmb (SMB client) - separate static library.
# ---------------------------------------------------------------------------
add_library(tinysmb STATIC
    libtinysmb/des.c
    libtinysmb/md4.c
    libtinysmb/ntlm.c
    libtinysmb/smb.c
    libtinysmb/smb_devoptab.c
)
target_include_directories(tinysmb PRIVATE ${LIBOGC_INCLUDES} INTERFACE $<INSTALL_INTERFACE:include>)
target_compile_options(tinysmb PRIVATE ${LIBOGC_OPTS})

#----------------------------------------------------------------------------
# libdb - GDB stub over TCP/Gecko
#----------------------------------------------------------------------------
add_library(gdbstub STATIC
    libdb/uIP/bba.c
    libdb/uIP/memb.c
    libdb/uIP/memr.c
    libdb/uIP/uip_arch.c
    libdb/uIP/uip_arp.c
    libdb/uIP/uip_icmp.c
    libdb/uIP/uip_ip.c
    libdb/uIP/uip_netif.c
    libdb/uIP/uip_pbuf.c
    libdb/uIP/uip_tcp.c
    
    libdb/debug.c
    libdb/debug_supp.c
    libdb/geckousb.c
    libdb/tcpip.c
)
target_include_directories(gdbstub PRIVATE ${LIBOGC_INCLUDES} INTERFACE $<INSTALL_INTERFACE:include>)
target_compile_options(gdbstub PRIVATE ${LIBOGC_OPTS})

# ---------------------------------------------------------------------------
# Install: archives, headers (devkitPPC layout so <gccore.h> and <ogc/*.h>
# both resolve from one include/), and the generated version header.
# ---------------------------------------------------------------------------
install(
    TARGETS gdbstub libogc tinysmb
    EXPORT libogc
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/gc/
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    FILES_MATCHING PATTERN "*.h" PATTERN "*.inc"
)
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/external/bsd/include/
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    FILES_MATCHING PATTERN "*.h"
)
install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/include/libversion.h
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include/ogc
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/libogcConfigVersion.cmake
    VERSION 3.1.0
    COMPATIBILITY SameMinorVersion
)
install(
    EXPORT libogc
    FILE libogcTargets.cmake
    NAMESPACE libogc::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libogc
)
install(
    FILES
        libogcConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/libogcConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libogc
)
