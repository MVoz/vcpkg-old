cmake_minimum_required(VERSION 3.6)

project(libdwarf C)

# Set the default build type to 'Release'.
if(NOT CMAKE_BUILD_TYPE)
	set(default_build_type "Release")
	message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
	set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE STRING "Choose the type of build." FORCE)
endif()

# On Linux and macOS, set RPATH relative to the origin of the installed
# libraries so that e.g. libdwarf can find libelf after installation. This
# allows us to move the installation directory into a different location after
# installation, which is useful e.g. when the installation is performed on one
# machine but we want to run the executables on a different machine.
#
# On Windows, there is no need to set anything as DLLs are usually installed
# into the binary directory, where they are automatically picked up by
# executables.
#
# For more details, see
#  - https://cmake.org/Wiki/CMake_RPATH_handling
if(APPLE)
	set(CMAKE_INSTALL_RPATH "@executable_path")
elseif(UNIX)
	set(CMAKE_INSTALL_RPATH "$ORIGIN")
endif()

set(LIBDWARF_SOURCES
	common.c
	dwarf_abbrev.c
	dwarf_addr_finder.c
	dwarf_alloc.c
	dwarf_arange.c
	dwarf_die_deliv.c
	dwarf_elf_access.c
	dwarf_error.c
	dwarf_form.c
	dwarf_frame.c
	dwarf_frame2.c
	dwarf_frame3.c
	dwarf_funcs.c
	dwarf_gdbindex.c
	dwarf_global.c
	dwarf_harmless.c
	dwarf_init_finish.c
	dwarf_leb.c
	dwarf_line.c
	dwarf_line2.c
	dwarf_loc.c
	dwarf_macro.c
	dwarf_names.c
	dwarf_original_elf_init.c
	dwarf_print_lines.c
	dwarf_pubtypes.c
	dwarf_query.c
	dwarf_ranges.c
	dwarf_sort_line.c
	dwarf_string.c
	dwarf_stubs.c
	dwarf_tsearchhash.c
	dwarf_types.c
	dwarf_util.c
	dwarf_vars.c
	dwarf_weaks.c
	dwarf_xu_index.c
	dwgetopt.c
	malloc_check.c
	pro_alloc.c
	pro_arange.c
	pro_die.c
	pro_encode_nm.c
	pro_error.c
	pro_expr.c
	pro_finish.c
	pro_forms.c
	pro_frame.c
	pro_funcs.c
	pro_init.c
	pro_line.c
	pro_macinfo.c
	pro_pubnames.c
	pro_reloc.c
	pro_reloc_stream.c
	pro_reloc_symbolic.c
	pro_section.c
	pro_types.c
	pro_vars.c
	pro_weaks.c
)

find_path(ELF_INCLUDE_DIR libelf.h)
find_library(ELF_LIBRARY libelf)

add_library(libdwarf STATIC ${LIBDWARF_SOURCES})
set_target_properties(libdwarf PROPERTIES OUTPUT_NAME "libdwarf")
target_link_libraries(libdwarf ${ELF_LIBRARY})

target_include_directories(libdwarf SYSTEM PRIVATE  
	${PROJECT_SOURCE_DIR}
	${ELF_INCLUDE_DIR}
	.
)

if(MSVC)
	set_target_properties(libdwarf PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
endif()

# Installation
SET(CMAKE_INSTALL_ALWAYS 1)

install(TARGETS ${targets}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)
