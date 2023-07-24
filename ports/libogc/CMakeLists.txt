cmake_minimum_required(VERSION 3.0)
project(libogc LANGUAGES C CXX)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/gc
)

add_library(libogc STATIC
    libogc/aes.c
    libogc/aram.c
    libogc/argv.c
    libogc/arqmgr.c
    libogc/arqueue.c
    libogc/audio.c
    libogc/cache_asm.S
    libogc/cache.c
    libogc/card.c
    libogc/cond.c
    libogc/conf.c
    libogc/console.c
    libogc/console_font_8x16.c
    libogc/decrementer.c
    libogc/decrementer_handler.S
    libogc/depackrnc1.c
    libogc/depackrnc.S
    libogc/dsp.c
    libogc/dvd.c
    libogc/es.c
    libogc/exception.c
    libogc/exception_handler.S
    libogc/exi.c
    libogc/gcsd.c
    libogc/gu.c
    libogc/gu_psasm.S
    libogc/gx.c
    libogc/ios.c
    libogc/ipc.c
    libogc/irq.c
    libogc/irq_handler.S
    libogc/isfs.c
    libogc/kprintf.c
    libogc/lock_supp.c
    libogc/lwp.c
    libogc/lwp_handler.S
    libogc/lwp_heap.c
    libogc/lwp_messages.c
    libogc/lwp_mutex.c
    libogc/lwp_objmgr.c
    libogc/lwp_priority.c
    libogc/lwp_queue.c
    libogc/lwp_sema.c
    libogc/lwp_stack.c
    libogc/lwp_threadq.c
    libogc/lwp_threads.c
    libogc/lwp_watchdog.c
    libogc/lwp_wkspace.c
    libogc/malloc_lock.c
    libogc/message.c
    libogc/mutex.c
    libogc/network_common.c
    libogc/network_wii.c
    libogc/ogc_crt0.S
    libogc/pad.c
    libogc/sbrk.c
    libogc/sdgecko_buf.c
    libogc/sdgecko_io.c
    libogc/semaphore.c
    libogc/sha.c
    libogc/si.c
    libogc/stm.c
    libogc/sys_state.c
    libogc/system_asm.S
    libogc/system.c
    libogc/texconv.c
    libogc/timesupp.c
    libogc/tpl.c
    libogc/usb.c
    libogc/usbgecko.c
    libogc/usbmouse.c
    libogc/usbstorage.c
    libogc/video_asm.S
    libogc/video.c
    libogc/wiilaunch.c
    libogc/wiisd.c
)
target_include_directories(libogc PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/bte
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/di
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/ipv4
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/lwip
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/modplay
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/netif
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/ogc
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/sdcard
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/sys
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/ogc/machine
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/wiikeyboard
  ${CMAKE_CURRENT_SOURCE_DIR}/gc/wiiuse
  ${CMAKE_CURRENT_BINARY_DIR}/include # For libversion.h
)
#add_library(lwip STATIC
#
#)

file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include)
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/include/libversion.h
"#pragma once

#define _V_MAJOR_ 1
#define _V_MINOR_ 8
#define _V_PATCH_ 21

#define _V_DATE_ __DATE__
#define _V_TIME_ __TIME__

#define _V_STRING \"libogc 1.8.21\""
)

install(
  TARGETS
    libogc
  EXPORT libogc
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(
  TARGETS 
    libogc 
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(
  FILES
gc/aesndlib.h
gc/asndlib.h
gc/debug.h
gc/gcbool.h
gc/gccore.h
gc/gcmodplay.h
gc/gctypes.h
gc/gcutil.h
gc/iso9660.h
gc/mad.h
gc/mp3player.h
gc/network.h
gc/ogcsys.h
gc/samplerate.h
gc/smb.h

gc/ipv4/lwip/icmp.h
gc/ipv4/lwip/inet.h
gc/ipv4/lwip/ip_addr.h
gc/ipv4/lwip/ip_frag.h
gc/ipv4/lwip/ip.h

gc/lwip/api.h
gc/lwip/api_msg.h
gc/lwip/arch.h
gc/lwip/debug.h
gc/lwip/def.h
gc/lwip/dhcp.h
gc/lwip/err.h
gc/lwip/lwipopts.h
gc/lwip/mem.h
gc/lwip/memp.h
gc/lwip/netif.h
gc/lwip/opt.h
gc/lwip/pbuf.h
gc/lwip/raw.h
gc/lwip/sio.h
gc/lwip/snmp.h
gc/lwip/sockets.h
gc/lwip/stats.h
gc/lwip/sys.h
gc/lwip/tcp.h
gc/lwip/tcpip.h
gc/lwip/udp.h

gc/netif/gcif/gcif.h
gc/netif/etharp.h
gc/netif/arch/init.h
gc/netif/arch/cpu.h
gc/netif/arch/lib.h
gc/netif/arch/perf.h
gc/netif/arch/cc.h
gc/netif/arch/sys_arch.h
gc/netif/loopif.h

gc/ogc/aes.h
gc/ogc/aram.h
gc/ogc/arqmgr.h
gc/ogc/arqueue.h
gc/ogc/audio.h
gc/ogc/cache.h
gc/ogc/card.h
gc/ogc/cast.h
gc/ogc/color.h
gc/ogc/cond.h
gc/ogc/conf.h
gc/ogc/consol.h
gc/ogc/context.h
gc/ogc/disc_io.h
gc/ogc/dsp.h
gc/ogc/dvd.h
gc/ogc/es.h
gc/ogc/exi.h
gc/ogc/gu.h
gc/ogc/gx.h
gc/ogc/gx_struct.h
gc/ogc/ios.h
gc/ogc/ipc.h
gc/ogc/irq.h
gc/ogc/isfs.h
gc/ogc/lwp_config.h
gc/ogc/lwp.h
gc/ogc/lwp_heap.h
gc/ogc/lwp_messages.h
gc/ogc/lwp_mutex.h
gc/ogc/lwp_objmgr.h
gc/ogc/lwp_priority.h
gc/ogc/lwp_queue.h
gc/ogc/lwp_sema.h
gc/ogc/lwp_stack.h
gc/ogc/lwp_states.h
gc/ogc/lwp_threadq.h
gc/ogc/lwp_threads.h
gc/ogc/lwp_tqdata.h
gc/ogc/lwp_watchdog.h
gc/ogc/lwp_wkspace.h
gc/ogc/message.h
gc/ogc/mutex.h
gc/ogc/pad.h
gc/ogc/semaphore.h
gc/ogc/sha.h
gc/ogc/si.h
gc/ogc/stm.h
gc/ogc/sys_state.h
gc/ogc/system.h
gc/ogc/texconv.h
gc/ogc/tpl.h
gc/ogc/usbgecko.h
gc/ogc/usb.h
gc/ogc/usbmouse.h
gc/ogc/usbstorage.h
gc/ogc/video.h
gc/ogc/video_types.h
gc/ogc/wiilaunch.h

gc/sys/mkdev.h

${CMAKE_CURRENT_BINARY_DIR}/include/libversion.h
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include/ogc/
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/libogcConfigVersion.cmake
  VERSION 2.4.1
  COMPATIBILITY SameMinorVersion
)

export(
  EXPORT libogc
  FILE ${CMAKE_CURRENT_BINARY_DIR}/libogcTargets.cmake
  NAMESPACE libogc::
)
install(
  EXPORT libogc 
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libogc
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
