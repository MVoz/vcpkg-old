#.rst:
# .. command:: vcpkg_replace_string
#
#  Replace a string in a file.
#
#  ::
#  vcpkg_replace_string(filename match_string replace_string)
#
#
function(vcpkg_replace_regex filename regular_expression replace_expression)
    file(READ ${filename} _contents)
    string(REGEX REPLACE "${match_string}" "${replace_expression}" _contents "${_contents}")
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
