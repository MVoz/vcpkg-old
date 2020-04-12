#.rst:
# .. command:: vcpkg_replace_string
#
#  Replace a string in a file.
#
#  ::
#  vcpkg_replace_string(filename match_string replace_string)
#
#  remove_srcs_file("${SOURCE_PATH}/include/*.in" "${SOURCE_PATH}/*.hin")

function(vcpkg_replace_string filename match_string replace_string)
    file(READ ${filename} _contents)
    string(REPLACE "${match_string}" "${replace_string}" _contents "${_contents}")
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
