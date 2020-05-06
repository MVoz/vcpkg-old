#.rst:
# .. command:: vcpkg_replace_string
#
#  Replace a string in a file.
#
#  ::
#  vcpkg_replace_string(filename match_string replace_string)
#
#
function(vcpkg_replace_string filename match_string replace_string)
    file(READ ${filename} _contents)
    string(REPLACE "${match_string}" "${replace_string}" _contents "${_contents}")
    file(WRITE ${filename} "${_contents}")
endfunction()

function(vcpkg_replace_regex filename regular_expression replace_expression)
    file(READ ${filename} _contents)
    string(REGEX REPLACE "${regular_expression}" "${replace_expression}" _contents "${_contents}")
    file(WRITE ${filename} "${_contents}")
endfunction()

function(remove_srcs_list_item)
      file(GLOB_RECURSE to_remove ${ARGN})
      list(REMOVE_ITEM srcs ${to_remove})
      set(srcs ${srcs} PARENT_SCOPE)
endfunction()

function(remove_srcs_file)
      file(GLOB_RECURSE to_remove ${ARGN})
      file(REMOVE_RECURSE srcs ${to_remove})
      set(srcs ${srcs} PARENT_SCOPE)
endfunction()

function(sleep delay)
  execute_process(
    COMMAND ${CMAKE_COMMAND} -E sleep ${delay}
    RESULT_VARIABLE result
    )
  if(NOT result EQUAL 0)
    message(FATAL_ERROR "failed to sleep for ${delay} second.")
  endif()
endfunction(sleep)

#.rst:
# .. command:: convert_cygwin_path
## convert_cygwin_path(petsc_lib_dir)
# message (STATUS "petsc_lib_dir ${petsc_lib_dir}")
## find_library (PETSC_LIBRARY_${suffix} NAMES ${libname} HINTS ${petsc_lib_dir} NO_DEFAULT_PATH)

function(convert_cygwin_path _path)
macro(convert_cygwin _path)
    if(NOT DEFINED CYGPATH_EXECUTABLE OR NOT EXISTS ${CYGPATH_EXECUTABLE} )
	  vcpkg_acquire_msys(MSYS_ROOT)
	  find_program(CYGPATH_EXECUTABLE NAMES cygpath HINTS
	            "/usr/bin/"
				"${MSYS_ROOT}/usr/bin"
				"${CYGWIN_INSTALL_PATH}/bin"
				"c:/cygwin/bin"
				"c:/cygwin64/bin"
				)
	  if(NOT EXISTS ${CYGPATH_EXECUTABLE}) 
        message(SEND_ERROR "cannot find cygpath.exe, please set CYGWIN_INSTALL_PATH variable with path where you have installed cygwin or CYGPATH_EXECUTABLE with path to cygpath.exe")
      endif()
	endif()
	  string(REGEX REPLACE "\\?space\\?" " " ${_path} ${${_path}})
      EXECUTE_PROCESS(COMMAND ${CYGPATH_EXECUTABLE} -w "${${_path}}"
        OUTPUT_VARIABLE ${_path})
      string(STRIP ${${_path}} ${_path})
	  string(REGEX REPLACE "\\\\" "/" ${_path} ${${_path}})
endmacro(convert_cygwin)
endfunction()

function(find_library suffix name)
  macro (FIND_LIBRARY suffix name)
    set (LIBRARY_${suffix} "NOTFOUND" CACHE INTERNAL "Cleared" FORCE) # Clear any stale value, if we got here, we need to find it again
    find_library (LIBRARY_${suffix} NAMES ${name} HINTS ${lib_dir} NO_DEFAULT_PATH)
    if (WIN32)
      set (libname lib${name}) #windows expects "libfoo", linux expects "foo"
    else (WIN32)
      set (libname ${name})
    endif (WIN32)
    find_library (LIBRARY_${suffix} NAMES ${libname} HINTS ${lib_dir} NO_DEFAULT_PATH)
    set (LIBRARIES_${suffix} "${LIBRARY_${suffix}}")
    mark_as_advanced (LIBRARY_${suffix})
  endmacro (FIND_LIBRARY suffix name)
endfunction()

function (resolve_libraries libs link_line)
macro (RESOLVE_LIBRARIES LIBS LINK_LINE)
  string (REGEX MATCHALL "((-L|-l|-Wl)([^\" ]+|\"[^\"]+\")|[^\" ]+\\.(a|so|dll|lib))" _all_tokens "${LINK_LINE}")
  set (_libs_found)
  set (_directory_list)
  foreach (token ${_all_tokens})
    if (token MATCHES "-L([^\" ]+|\"[^\"]+\")")
      # If it's a library path, add it to the list
      string (REGEX REPLACE "^-L" "" token ${token})
      string (REGEX REPLACE "//" "/" token ${token})
      convert_cygwin_path(token)
      list (APPEND _directory_list ${token})
    elseif (token MATCHES "^(-l([^\" ]+|\"[^\"]+\")|[^\" ]+\\.(a|so|dll|lib))")
      # It's a library, resolve the path by looking in the list and then (by default) in system directories
      if (WIN32) #windows expects "libfoo", linux expects "foo"
        string (REGEX REPLACE "^-l" "lib" token ${token})
      else (WIN32)
        string (REGEX REPLACE "^-l" "" token ${token})
      endif (WIN32)
      set (_root)
      if (token MATCHES "^/")   # We have an absolute path
        #separate into a path and a library name:
        string (REGEX MATCH "[^/]*\\.(a|so|dll|lib)$" libname ${token})
        string (REGEX MATCH ".*[^${libname}$]" libpath ${token})
        convert_cygwin_path(libpath)
        set (_directory_list ${_directory_list} ${libpath})
        set (token ${libname})
      endif (token MATCHES "^/")
      set (_lib "NOTFOUND" CACHE FILEPATH "Cleared" FORCE)
      find_library (_lib ${token} HINTS ${_directory_list} ${_root})
      if (_lib)
    string (REPLACE "//" "/" _lib ${_lib})
        list (APPEND _libs_found ${_lib})
      else (_lib)
        message (STATUS "Unable to find library ${token}")
      endif (_lib)
    endif (token MATCHES "-L([^\" ]+|\"[^\"]+\")")
  endforeach (token)
  set (_lib "NOTFOUND" CACHE INTERNAL "Scratch variable" FORCE)
  # only the LAST occurence of each library is required since there should be no circular dependencies
  if (_libs_found)
    list (REVERSE _libs_found)
    list (REMOVE_DUPLICATES _libs_found)
    list (REVERSE _libs_found)
  endif (_libs_found)
  set (${LIBS} "${_libs_found}")
endmacro (RESOLVE_LIBRARIES)
endfunction()

function (resolve_includes incs compile_line)
macro (RESOLVE_INCLUDES INCS COMPILE_LINE)
  string (REGEX MATCHALL "-I([^\" ]+|\"[^\"]+\")" _all_tokens "${COMPILE_LINE}")
  set (_incs_found "")
  foreach (token ${_all_tokens})
    string (REGEX REPLACE "^-I" "" token ${token})
    string (REGEX REPLACE "//" "/" token ${token})
    convert_cygwin_path(token)
    if (EXISTS ${token})
      list (APPEND _incs_found ${token})
    else (EXISTS ${token})
      message (STATUS "Include directory ${token} does not exist")
    endif (EXISTS ${token})
  endforeach (token)
  list (REMOVE_DUPLICATES _incs_found)
  set (${INCS} "${_incs_found}")
endmacro (RESOLVE_INCLUDES)
endfunction()





