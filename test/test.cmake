# test dependencies
find_package(SQLite3 REQUIRED)
find_package(CASSERTS REQUIRED)
find_package(CURL REQUIRED)
find_package(Threads REQUIRED)
find_package(OpenSSL REQUIRED)

# Include Library directories
include_directories(
        ${SQLite3_INCLUDE_DIRS}
        ${CASSERTS_INCLUDE_DIR}
        ${CURL_INCLUDE_DIRS}
        ${OPENSSL_INCLUDE_DIR}
        .
        src
)

set(SOURCES_TEST
        test/download.c
        test/download.h
        test/enginecache.c
        test/enginecache.h
        test/hoster.c
        test/hoster.h
        test/hoster_freeroms.c
        test/hoster_freeroms.h
        test/hoster_romhustler.c
        test/hoster_romhustler.h
        test/hoster_romsdownload.c
        test/hoster_romsdownload.h
        test/hoster_wowroms.c
        test/hoster_wowroms.h
        test/systems.c
        test/systems.h
        test/test.c
        test/test.h
        )

enable_testing()
add_executable(romlibrary_testcases ${SOURCES_TEST})
target_link_libraries(romlibrary_testcases romlibrary_static ${SQLite3_LIBRARIES} ${OPENSSL_LIBRARIES} ${CURL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})

add_test(NAME test_engine_freeroms_3do COMMAND romlibrary_testcases test_engine_freeroms_3do)
add_test(NAME test_engine_freeroms_amiga COMMAND romlibrary_testcases test_engine_freeroms_amiga)
add_test(NAME test_engine_freeroms_atari2600 COMMAND romlibrary_testcases test_engine_freeroms_atari2600)
add_test(NAME test_engine_freeroms_atari7800 COMMAND romlibrary_testcases test_engine_freeroms_atari7800)
add_test(NAME test_engine_freeroms_atarijaguar COMMAND romlibrary_testcases test_engine_freeroms_atarijaguar)
add_test(NAME test_engine_freeroms_atarilynx COMMAND romlibrary_testcases test_engine_freeroms_atarilynx)
add_test(NAME test_engine_freeroms_atarist COMMAND romlibrary_testcases test_engine_freeroms_atarist)
add_test(NAME test_engine_freeroms_c64 COMMAND romlibrary_testcases test_engine_freeroms_c64)
add_test(NAME test_engine_freeroms_dreamcast COMMAND romlibrary_testcases test_engine_freeroms_dreamcast)
add_test(NAME test_engine_freeroms_fba COMMAND romlibrary_testcases test_engine_freeroms_fba)
add_test(NAME test_engine_freeroms_fds COMMAND romlibrary_testcases test_engine_freeroms_fds)
add_test(NAME test_engine_freeroms_gamegear COMMAND romlibrary_testcases test_engine_freeroms_gamegear)
add_test(NAME test_engine_freeroms_gb COMMAND romlibrary_testcases test_engine_freeroms_gb)
add_test(NAME test_engine_freeroms_gba COMMAND romlibrary_testcases test_engine_freeroms_gba)
add_test(NAME test_engine_freeroms_gbc COMMAND romlibrary_testcases test_engine_freeroms_gbc)
add_test(NAME test_engine_freeroms_gc COMMAND romlibrary_testcases test_engine_freeroms_gc)
add_test(NAME test_engine_freeroms_genesis COMMAND romlibrary_testcases test_engine_freeroms_genesis)
add_test(NAME test_engine_freeroms_gw COMMAND romlibrary_testcases test_engine_freeroms_gw)
add_test(NAME test_engine_freeroms_love COMMAND romlibrary_testcases test_engine_freeroms_love)
add_test(NAME test_engine_freeroms_mame COMMAND romlibrary_testcases test_engine_freeroms_mame)
add_test(NAME test_engine_freeroms_mastersystem COMMAND romlibrary_testcases test_engine_freeroms_mastersystem)
add_test(NAME test_engine_freeroms_megadrive COMMAND romlibrary_testcases test_engine_freeroms_megadrive)
add_test(NAME test_engine_freeroms_msx COMMAND romlibrary_testcases test_engine_freeroms_msx)
add_test(NAME test_engine_freeroms_n64 COMMAND romlibrary_testcases test_engine_freeroms_n64)
add_test(NAME test_engine_freeroms_nds COMMAND romlibrary_testcases test_engine_freeroms_nds)
add_test(NAME test_engine_freeroms_neogeo COMMAND romlibrary_testcases test_engine_freeroms_neogeo)
add_test(NAME test_engine_freeroms_nes COMMAND romlibrary_testcases test_engine_freeroms_nes)
add_test(NAME test_engine_freeroms_ngp COMMAND romlibrary_testcases test_engine_freeroms_ngp)
add_test(NAME test_engine_freeroms_ngpc COMMAND romlibrary_testcases test_engine_freeroms_ngpc)
add_test(NAME test_engine_freeroms_pc COMMAND romlibrary_testcases test_engine_freeroms_pc)
add_test(NAME test_engine_freeroms_pcengine COMMAND romlibrary_testcases test_engine_freeroms_pcengine)
add_test(NAME test_engine_freeroms_pcfx COMMAND romlibrary_testcases test_engine_freeroms_pcfx)
add_test(NAME test_engine_freeroms_ps2 COMMAND romlibrary_testcases test_engine_freeroms_ps2)
add_test(NAME test_engine_freeroms_psp COMMAND romlibrary_testcases test_engine_freeroms_psp)
add_test(NAME test_engine_freeroms_psx COMMAND romlibrary_testcases test_engine_freeroms_psx)
add_test(NAME test_engine_freeroms_saturn COMMAND romlibrary_testcases test_engine_freeroms_saturn)
add_test(NAME test_engine_freeroms_scummvm COMMAND romlibrary_testcases test_engine_freeroms_scummvm)
add_test(NAME test_engine_freeroms_sega32x COMMAND romlibrary_testcases test_engine_freeroms_sega32x)
add_test(NAME test_engine_freeroms_segacd COMMAND romlibrary_testcases test_engine_freeroms_segacd)
add_test(NAME test_engine_freeroms_sg1000 COMMAND romlibrary_testcases test_engine_freeroms_sg1000)
add_test(NAME test_engine_freeroms_snes COMMAND romlibrary_testcases test_engine_freeroms_snes)
add_test(NAME test_engine_freeroms_vectrex COMMAND romlibrary_testcases test_engine_freeroms_vectrex)
add_test(NAME test_engine_freeroms_videopac COMMAND romlibrary_testcases test_engine_freeroms_videopac)
add_test(NAME test_engine_freeroms_virtualboy COMMAND romlibrary_testcases test_engine_freeroms_virtualboy)
add_test(NAME test_engine_freeroms_wii COMMAND romlibrary_testcases test_engine_freeroms_wii)
add_test(NAME test_engine_freeroms_wiiu COMMAND romlibrary_testcases test_engine_freeroms_wiiu)
add_test(NAME test_engine_freeroms_wonderswan COMMAND romlibrary_testcases test_engine_freeroms_wonderswan)
add_test(NAME test_engine_freeroms_wonderswancolor COMMAND romlibrary_testcases test_engine_freeroms_wonderswancolor)
add_test(NAME test_engine_freeroms_zxspectrum COMMAND romlibrary_testcases test_engine_freeroms_zxspectrum)
add_test(NAME test_engine_freeroms_download COMMAND romlibrary_testcases test_engine_freeroms_download)

add_test(NAME test_engine_romhustler_3do COMMAND romlibrary_testcases test_engine_romhustler_3do)
add_test(NAME test_engine_romhustler_amiga COMMAND romlibrary_testcases test_engine_romhustler_amiga)
add_test(NAME test_engine_romhustler_atari2600 COMMAND romlibrary_testcases test_engine_romhustler_atari2600)
add_test(NAME test_engine_romhustler_atari7800 COMMAND romlibrary_testcases test_engine_romhustler_atari7800)
add_test(NAME test_engine_romhustler_atarijaguar COMMAND romlibrary_testcases test_engine_romhustler_atarijaguar)
add_test(NAME test_engine_romhustler_atarilynx COMMAND romlibrary_testcases test_engine_romhustler_atarilynx)
add_test(NAME test_engine_romhustler_atarist COMMAND romlibrary_testcases test_engine_romhustler_atarist)
add_test(NAME test_engine_romhustler_c64 COMMAND romlibrary_testcases test_engine_romhustler_c64)
add_test(NAME test_engine_romhustler_dreamcast COMMAND romlibrary_testcases test_engine_romhustler_dreamcast)
add_test(NAME test_engine_romhustler_fba COMMAND romlibrary_testcases test_engine_romhustler_fba)
add_test(NAME test_engine_romhustler_fds COMMAND romlibrary_testcases test_engine_romhustler_fds)
add_test(NAME test_engine_romhustler_gamegear COMMAND romlibrary_testcases test_engine_romhustler_gamegear)
add_test(NAME test_engine_romhustler_gb COMMAND romlibrary_testcases test_engine_romhustler_gb)
add_test(NAME test_engine_romhustler_gba COMMAND romlibrary_testcases test_engine_romhustler_gba)
add_test(NAME test_engine_romhustler_gbc COMMAND romlibrary_testcases test_engine_romhustler_gbc)
add_test(NAME test_engine_romhustler_gc COMMAND romlibrary_testcases test_engine_romhustler_gc)
add_test(NAME test_engine_romhustler_genesis COMMAND romlibrary_testcases test_engine_romhustler_genesis)
add_test(NAME test_engine_romhustler_gw COMMAND romlibrary_testcases test_engine_romhustler_gw)
add_test(NAME test_engine_romhustler_love COMMAND romlibrary_testcases test_engine_romhustler_love)
add_test(NAME test_engine_romhustler_mame COMMAND romlibrary_testcases test_engine_romhustler_mame)
add_test(NAME test_engine_romhustler_mastersystem COMMAND romlibrary_testcases test_engine_romhustler_mastersystem)
add_test(NAME test_engine_romhustler_megadrive COMMAND romlibrary_testcases test_engine_romhustler_megadrive)
add_test(NAME test_engine_romhustler_msx COMMAND romlibrary_testcases test_engine_romhustler_msx)
add_test(NAME test_engine_romhustler_n64 COMMAND romlibrary_testcases test_engine_romhustler_n64)
add_test(NAME test_engine_romhustler_nds COMMAND romlibrary_testcases test_engine_romhustler_nds)
add_test(NAME test_engine_romhustler_neogeo COMMAND romlibrary_testcases test_engine_romhustler_neogeo)
add_test(NAME test_engine_romhustler_nes COMMAND romlibrary_testcases test_engine_romhustler_nes)
add_test(NAME test_engine_romhustler_ngp COMMAND romlibrary_testcases test_engine_romhustler_ngp)
add_test(NAME test_engine_romhustler_ngpc COMMAND romlibrary_testcases test_engine_romhustler_ngpc)
add_test(NAME test_engine_romhustler_pc COMMAND romlibrary_testcases test_engine_romhustler_pc)
add_test(NAME test_engine_romhustler_pcengine COMMAND romlibrary_testcases test_engine_romhustler_pcengine)
add_test(NAME test_engine_romhustler_pcfx COMMAND romlibrary_testcases test_engine_romhustler_pcfx)
add_test(NAME test_engine_romhustler_ps2 COMMAND romlibrary_testcases test_engine_romhustler_ps2)
add_test(NAME test_engine_romhustler_psp COMMAND romlibrary_testcases test_engine_romhustler_psp)
add_test(NAME test_engine_romhustler_psx COMMAND romlibrary_testcases test_engine_romhustler_psx)
add_test(NAME test_engine_romhustler_saturn COMMAND romlibrary_testcases test_engine_romhustler_saturn)
add_test(NAME test_engine_romhustler_scummvm COMMAND romlibrary_testcases test_engine_romhustler_scummvm)
add_test(NAME test_engine_romhustler_sega32x COMMAND romlibrary_testcases test_engine_romhustler_sega32x)
add_test(NAME test_engine_romhustler_segacd COMMAND romlibrary_testcases test_engine_romhustler_segacd)
add_test(NAME test_engine_romhustler_sg1000 COMMAND romlibrary_testcases test_engine_romhustler_sg1000)
add_test(NAME test_engine_romhustler_snes COMMAND romlibrary_testcases test_engine_romhustler_snes)
add_test(NAME test_engine_romhustler_vectrex COMMAND romlibrary_testcases test_engine_romhustler_vectrex)
add_test(NAME test_engine_romhustler_videopac COMMAND romlibrary_testcases test_engine_romhustler_videopac)
add_test(NAME test_engine_romhustler_virtualboy COMMAND romlibrary_testcases test_engine_romhustler_virtualboy)
add_test(NAME test_engine_romhustler_wii COMMAND romlibrary_testcases test_engine_romhustler_wii)
add_test(NAME test_engine_romhustler_wiiu COMMAND romlibrary_testcases test_engine_romhustler_wiiu)
add_test(NAME test_engine_romhustler_wonderswan COMMAND romlibrary_testcases test_engine_romhustler_wonderswan)
add_test(NAME test_engine_romhustler_wonderswancolor COMMAND romlibrary_testcases test_engine_romhustler_wonderswancolor)
add_test(NAME test_engine_romhustler_zxspectrum COMMAND romlibrary_testcases test_engine_romhustler_zxspectrum)
add_test(NAME test_engine_romhustler_download COMMAND romlibrary_testcases test_engine_romhustler_download)

add_test(NAME test_engine_romsdownload_3do COMMAND romlibrary_testcases test_engine_romsdownload_3do)
add_test(NAME test_engine_romsdownload_amiga COMMAND romlibrary_testcases test_engine_romsdownload_amiga)
add_test(NAME test_engine_romsdownload_atari2600 COMMAND romlibrary_testcases test_engine_romsdownload_atari2600)
add_test(NAME test_engine_romsdownload_atari7800 COMMAND romlibrary_testcases test_engine_romsdownload_atari7800)
add_test(NAME test_engine_romsdownload_atarijaguar COMMAND romlibrary_testcases test_engine_romsdownload_atarijaguar)
add_test(NAME test_engine_romsdownload_atarilynx COMMAND romlibrary_testcases test_engine_romsdownload_atarilynx)
add_test(NAME test_engine_romsdownload_atarist COMMAND romlibrary_testcases test_engine_romsdownload_atarist)
add_test(NAME test_engine_romsdownload_c64 COMMAND romlibrary_testcases test_engine_romsdownload_c64)
add_test(NAME test_engine_romsdownload_dreamcast COMMAND romlibrary_testcases test_engine_romsdownload_dreamcast)
add_test(NAME test_engine_romsdownload_fba COMMAND romlibrary_testcases test_engine_romsdownload_fba)
add_test(NAME test_engine_romsdownload_fds COMMAND romlibrary_testcases test_engine_romsdownload_fds)
add_test(NAME test_engine_romsdownload_gamegear COMMAND romlibrary_testcases test_engine_romsdownload_gamegear)
add_test(NAME test_engine_romsdownload_gb COMMAND romlibrary_testcases test_engine_romsdownload_gb)
add_test(NAME test_engine_romsdownload_gba COMMAND romlibrary_testcases test_engine_romsdownload_gba)
add_test(NAME test_engine_romsdownload_gbc COMMAND romlibrary_testcases test_engine_romsdownload_gbc)
add_test(NAME test_engine_romsdownload_gc COMMAND romlibrary_testcases test_engine_romsdownload_gc)
add_test(NAME test_engine_romsdownload_genesis COMMAND romlibrary_testcases test_engine_romsdownload_genesis)
add_test(NAME test_engine_romsdownload_gw COMMAND romlibrary_testcases test_engine_romsdownload_gw)
add_test(NAME test_engine_romsdownload_love COMMAND romlibrary_testcases test_engine_romsdownload_love)
add_test(NAME test_engine_romsdownload_mame COMMAND romlibrary_testcases test_engine_romsdownload_mame)
add_test(NAME test_engine_romsdownload_mastersystem COMMAND romlibrary_testcases test_engine_romsdownload_mastersystem)
add_test(NAME test_engine_romsdownload_megadrive COMMAND romlibrary_testcases test_engine_romsdownload_megadrive)
add_test(NAME test_engine_romsdownload_msx COMMAND romlibrary_testcases test_engine_romsdownload_msx)
add_test(NAME test_engine_romsdownload_n64 COMMAND romlibrary_testcases test_engine_romsdownload_n64)
add_test(NAME test_engine_romsdownload_nds COMMAND romlibrary_testcases test_engine_romsdownload_nds)
add_test(NAME test_engine_romsdownload_neogeo COMMAND romlibrary_testcases test_engine_romsdownload_neogeo)
add_test(NAME test_engine_romsdownload_nes COMMAND romlibrary_testcases test_engine_romsdownload_nes)
add_test(NAME test_engine_romsdownload_ngp COMMAND romlibrary_testcases test_engine_romsdownload_ngp)
add_test(NAME test_engine_romsdownload_ngpc COMMAND romlibrary_testcases test_engine_romsdownload_ngpc)
add_test(NAME test_engine_romsdownload_pc COMMAND romlibrary_testcases test_engine_romsdownload_pc)
add_test(NAME test_engine_romsdownload_pcengine COMMAND romlibrary_testcases test_engine_romsdownload_pcengine)
add_test(NAME test_engine_romsdownload_pcfx COMMAND romlibrary_testcases test_engine_romsdownload_pcfx)
add_test(NAME test_engine_romsdownload_ps2 COMMAND romlibrary_testcases test_engine_romsdownload_ps2)
add_test(NAME test_engine_romsdownload_psp COMMAND romlibrary_testcases test_engine_romsdownload_psp)
add_test(NAME test_engine_romsdownload_psx COMMAND romlibrary_testcases test_engine_romsdownload_psx)
add_test(NAME test_engine_romsdownload_saturn COMMAND romlibrary_testcases test_engine_romsdownload_saturn)
add_test(NAME test_engine_romsdownload_scummvm COMMAND romlibrary_testcases test_engine_romsdownload_scummvm)
add_test(NAME test_engine_romsdownload_sega32x COMMAND romlibrary_testcases test_engine_romsdownload_sega32x)
add_test(NAME test_engine_romsdownload_segacd COMMAND romlibrary_testcases test_engine_romsdownload_segacd)
add_test(NAME test_engine_romsdownload_sg1000 COMMAND romlibrary_testcases test_engine_romsdownload_sg1000)
add_test(NAME test_engine_romsdownload_snes COMMAND romlibrary_testcases test_engine_romsdownload_snes)
add_test(NAME test_engine_romsdownload_vectrex COMMAND romlibrary_testcases test_engine_romsdownload_vectrex)
add_test(NAME test_engine_romsdownload_videopac COMMAND romlibrary_testcases test_engine_romsdownload_videopac)
add_test(NAME test_engine_romsdownload_virtualboy COMMAND romlibrary_testcases test_engine_romsdownload_virtualboy)
add_test(NAME test_engine_romsdownload_wii COMMAND romlibrary_testcases test_engine_romsdownload_wii)
add_test(NAME test_engine_romsdownload_wiiu COMMAND romlibrary_testcases test_engine_romsdownload_wiiu)
add_test(NAME test_engine_romsdownload_wonderswan COMMAND romlibrary_testcases test_engine_romsdownload_wonderswan)
add_test(NAME test_engine_romsdownload_wonderswancolor COMMAND romlibrary_testcases test_engine_romsdownload_wonderswancolor)
add_test(NAME test_engine_romsdownload_zxspectrum COMMAND romlibrary_testcases test_engine_romsdownload_zxspectrum)
add_test(NAME test_engine_romsdownload_download COMMAND romlibrary_testcases test_engine_romsdownload_download)

add_test(NAME test_engine_wowroms_3do COMMAND romlibrary_testcases test_engine_wowroms_3do)
add_test(NAME test_engine_wowroms_amiga COMMAND romlibrary_testcases test_engine_wowroms_amiga)
add_test(NAME test_engine_wowroms_atari2600 COMMAND romlibrary_testcases test_engine_wowroms_atari2600)
add_test(NAME test_engine_wowroms_atari7800 COMMAND romlibrary_testcases test_engine_wowroms_atari7800)
add_test(NAME test_engine_wowroms_atarijaguar COMMAND romlibrary_testcases test_engine_wowroms_atarijaguar)
add_test(NAME test_engine_wowroms_atarilynx COMMAND romlibrary_testcases test_engine_wowroms_atarilynx)
add_test(NAME test_engine_wowroms_atarist COMMAND romlibrary_testcases test_engine_wowroms_atarist)
add_test(NAME test_engine_wowroms_c64 COMMAND romlibrary_testcases test_engine_wowroms_c64)
add_test(NAME test_engine_wowroms_dreamcast COMMAND romlibrary_testcases test_engine_wowroms_dreamcast)
add_test(NAME test_engine_wowroms_fba COMMAND romlibrary_testcases test_engine_wowroms_fba)
add_test(NAME test_engine_wowroms_fds COMMAND romlibrary_testcases test_engine_wowroms_fds)
add_test(NAME test_engine_wowroms_gamegear COMMAND romlibrary_testcases test_engine_wowroms_gamegear)
add_test(NAME test_engine_wowroms_gb COMMAND romlibrary_testcases test_engine_wowroms_gb)
add_test(NAME test_engine_wowroms_gba COMMAND romlibrary_testcases test_engine_wowroms_gba)
add_test(NAME test_engine_wowroms_gbc COMMAND romlibrary_testcases test_engine_wowroms_gbc)
add_test(NAME test_engine_wowroms_gc COMMAND romlibrary_testcases test_engine_wowroms_gc)
add_test(NAME test_engine_wowroms_genesis COMMAND romlibrary_testcases test_engine_wowroms_genesis)
add_test(NAME test_engine_wowroms_gw COMMAND romlibrary_testcases test_engine_wowroms_gw)
add_test(NAME test_engine_wowroms_love COMMAND romlibrary_testcases test_engine_wowroms_love)
add_test(NAME test_engine_wowroms_mame COMMAND romlibrary_testcases test_engine_wowroms_mame)
add_test(NAME test_engine_wowroms_mastersystem COMMAND romlibrary_testcases test_engine_wowroms_mastersystem)
add_test(NAME test_engine_wowroms_megadrive COMMAND romlibrary_testcases test_engine_wowroms_megadrive)
add_test(NAME test_engine_wowroms_msx COMMAND romlibrary_testcases test_engine_wowroms_msx)
add_test(NAME test_engine_wowroms_n64 COMMAND romlibrary_testcases test_engine_wowroms_n64)
add_test(NAME test_engine_wowroms_nds COMMAND romlibrary_testcases test_engine_wowroms_nds)
add_test(NAME test_engine_wowroms_neogeo COMMAND romlibrary_testcases test_engine_wowroms_neogeo)
add_test(NAME test_engine_wowroms_nes COMMAND romlibrary_testcases test_engine_wowroms_nes)
add_test(NAME test_engine_wowroms_ngp COMMAND romlibrary_testcases test_engine_wowroms_ngp)
add_test(NAME test_engine_wowroms_ngpc COMMAND romlibrary_testcases test_engine_wowroms_ngpc)
add_test(NAME test_engine_wowroms_pc COMMAND romlibrary_testcases test_engine_wowroms_pc)
add_test(NAME test_engine_wowroms_pcengine COMMAND romlibrary_testcases test_engine_wowroms_pcengine)
add_test(NAME test_engine_wowroms_pcfx COMMAND romlibrary_testcases test_engine_wowroms_pcfx)
add_test(NAME test_engine_wowroms_ps2 COMMAND romlibrary_testcases test_engine_wowroms_ps2)
add_test(NAME test_engine_wowroms_psp COMMAND romlibrary_testcases test_engine_wowroms_psp)
add_test(NAME test_engine_wowroms_psx COMMAND romlibrary_testcases test_engine_wowroms_psx)
add_test(NAME test_engine_wowroms_saturn COMMAND romlibrary_testcases test_engine_wowroms_saturn)
add_test(NAME test_engine_wowroms_scummvm COMMAND romlibrary_testcases test_engine_wowroms_scummvm)
add_test(NAME test_engine_wowroms_sega32x COMMAND romlibrary_testcases test_engine_wowroms_sega32x)
add_test(NAME test_engine_wowroms_segacd COMMAND romlibrary_testcases test_engine_wowroms_segacd)
add_test(NAME test_engine_wowroms_sg1000 COMMAND romlibrary_testcases test_engine_wowroms_sg1000)
add_test(NAME test_engine_wowroms_snes COMMAND romlibrary_testcases test_engine_wowroms_snes)
add_test(NAME test_engine_wowroms_vectrex COMMAND romlibrary_testcases test_engine_wowroms_vectrex)
add_test(NAME test_engine_wowroms_videopac COMMAND romlibrary_testcases test_engine_wowroms_videopac)
add_test(NAME test_engine_wowroms_virtualboy COMMAND romlibrary_testcases test_engine_wowroms_virtualboy)
add_test(NAME test_engine_wowroms_wii COMMAND romlibrary_testcases test_engine_wowroms_wii)
add_test(NAME test_engine_wowroms_wiiu COMMAND romlibrary_testcases test_engine_wowroms_wiiu)
add_test(NAME test_engine_wowroms_wonderswan COMMAND romlibrary_testcases test_engine_wowroms_wonderswan)
add_test(NAME test_engine_wowroms_wonderswancolor COMMAND romlibrary_testcases test_engine_wowroms_wonderswancolor)
add_test(NAME test_engine_wowroms_zxspectrum COMMAND romlibrary_testcases test_engine_wowroms_zxspectrum)
add_test(NAME test_engine_wowroms_download COMMAND romlibrary_testcases test_engine_wowroms_download)