include(vcpkg_common_functions)

find_program(GIT NAMES git git.cmd)
set(GIT_URL "https://github.com/libigl/libigl")
set(GIT_REV master)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
if(NOT EXISTS "${SOURCE_PATH}/.git")
    message(STATUS "Cloning and fetching submodules")
    vcpkg_execute_required_process(
      COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME clone
    )
    message(STATUS "Checkout revision ${GIT_REV}")
    vcpkg_execute_required_process(
      COMMAND ${GIT} checkout ${GIT_REV}
      WORKING_DIRECTORY ${SOURCE_PATH}
      LOGNAME checkout
    )
endif()

vcpkg_find_acquire_program(PYTHON3)
#vcpkg_find_acquire_program(QT5)
#vcpkg_find_acquire_program(TEXLIVE)
#vcpkg_find_acquire_program(XGETTEXT)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(DOXYGEN)
#vcpkg_find_acquire_program(PERL)
#vcpkg_find_acquire_program(FLEX)
#vcpkg_find_acquire_program(BISON)
#get_filename_component(FLEX_DIR "${FLEX}" DIRECTORY)
#get_filename_component(BISON_DIR "${BISON}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(PERL_DIR "${PERL}" DIRECTORY)
#get_filename_component(QT5_DIR "${QT5}" DIRECTORY)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
#get_filename_component(DOXYGEN_DIR "${DOXYGEN}" DIRECTORY)
#get_filename_component(XGETTEXT_DIR "${XGETTEXT}" DIRECTORY)
#get_filename_component(TEXLIVE_DIR "${TEXLIVE}" DIRECTORY)
#set(ENV{PATH} ";$ENV{PATH};${QT5_DIR};${PYTHON3_DIR};${DOXYGEN_DIR};${XGETTEXT_DIR};${TEXLIVE_DIR};${FLEX_DIR};${BISON_DIR};${DOXYGEN_DIR};${PERL_DIR}")
#vcpkg_find_acquire_program(YASM)
#get_filename_component(YASM_EXE_PATH ${YASM} DIRECTORY)
set(ENV{PATH} "$ENV{PATH};${PYTHON3_DIR}")

#get_filename_component(GIT_EXE_PATH ${GIT} DIRECTORY)
#set(SH_EXE_PATH "${GIT_EXE_PATH}/../usr/bin")
#set(ENV{PATH} "$ENV{PATH};${VALAC_DIR};${BISON_DIR};${FLEX_DIR};${SH_EXE_PATH}")

#file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    NO_CHARSET_FLAG # automatic templates
#    GENERATOR "NMake Makefiles" # automatic templates
#    DISABLE_PARALLEL_CONFIGURE
    OPTIONS_DEBUG # automatic templates
      -DDISABLE_INSTALL_HEADERS=ON # automatic templates
      -DINSTALL_HEADERS_TOOLS=OFF
      -DINSTALL_HEADERS=OFF
    OPTIONS_RELEASE 
      -DINSTALL_HEADERS=ON # automatic templates
#      -D =OFF
    OPTIONS 
      -DBUILD_SHARED_LIBS=ON
      -DEMBREE_STATIC_RUNTIME=OFF
      -DLIBIGL_USE_STATIC_LIBRARY=OFF
	  
      -DBUILD_TESTING=OFF
      -DCATCH_BUILD_EXAMPLES=OFF
      -DCATCH_BUILD_EXTRA_TESTS=OFF
      -DCATCH_BUILD_TESTING=OFF
      -DCATCH_ENABLE_COVERAGE=OFF
      -DCATCH_ENABLE_WERROR=OFF
      -DCATCH_INSTALL_DOCS=OFF
      -DCATCH_INSTALL_HELPERS=OFF
      -DCATCH_USE_VALGRIND=OFF
      -DEMBREE_BACKFACE_CULLING=OFF
      -DEMBREE_FILTER_FUNCTION=ON
      -DEMBREE_GEOMETRY_CURVE=ON
      -DEMBREE_GEOMETRY_GRID=ON
      -DEMBREE_GEOMETRY_INSTANCE=ON
      -DEMBREE_GEOMETRY_POINT=ON
      -DEMBREE_GEOMETRY_QUAD=ON
      -DEMBREE_GEOMETRY_SUBDIVISION=ON
      -DEMBREE_GEOMETRY_TRIANGLE=ON
      -DEMBREE_GEOMETRY_USER=ON
      -DEMBREE_IGNORE_INVALID_RAYS=OFF
      -DEMBREE_ISPC_SUPPORT=OFF
      -DEMBREE_RAY_MASK=OFF
      -DEMBREE_RAY_PACKETS=ON
      -DEMBREE_STACK_PROTECTOR=OFF
      -DEMBREE_STAT_COUNTERS=OFF
      -DEMBREE_TESTING_BENCHMARK=OFF
      -DEMBREE_TESTING_KLOCWORK=OFF
      -DEMBREE_TESTING_MEMCHECK=OFF
      -DEMBREE_TESTING_PACKAGE=OFF
      -DEMBREE_TESTING_SDE=OFF
      -DEMBREE_TUTORIALS=OFF
      -DGLFW_BUILD_DOCS=OFF
      -DGLFW_BUILD_EXAMPLES=OFF
      -DGLFW_BUILD_TESTS=OFF
      -DGLFW_INSTALL=OFF
      -DGLFW_USE_HYBRID_HPG=OFF
      -DGLFW_VULKAN_STATIC=OFF
      -DLIBIGL_BUILD_PYTHON=OFF
      -DLIBIGL_BUILD_TESTS=OFF
      -DLIBIGL_BUILD_TUTORIALS=OFF
      -DLIBIGL_EXPORT_TARGETS=ON
      -DLIBIGL_SKIP_DOWNLOAD=OFF
      -DLIBIGL_WITHOUT_COPYLEFT=OFF
      -DLIBIGL_WITH_CGAL=ON
      -DLIBIGL_WITH_COMISO=ON
      -DLIBIGL_WITH_CORK=ON
      -DLIBIGL_WITH_EMBREE=ON
      -DLIBIGL_WITH_MATLAB=OFF
      -DLIBIGL_WITH_MOSEK=ON
      -DLIBIGL_WITH_OPENGL=ON
      -DLIBIGL_WITH_OPENGL_GLFW=ON
      -DLIBIGL_WITH_OPENGL_GLFW_IMGUI=ON
      -DLIBIGL_WITH_PNG=ON
      -DLIBIGL_WITH_PREDICATES=ON
      -DLIBIGL_WITH_PYTHON=OFF
      -DLIBIGL_WITH_TETGEN=ON
      -DLIBIGL_WITH_TRIANGLE=ON
      -DLIBIGL_WITH_XML=ON
      -DPYBIND11_INSTALL=OFF
      -DPYBIND11_TEST=OFF
      -DTUTORIALS_CHAPTER1=OFF
      -DTUTORIALS_CHAPTER2=OFF
      -DTUTORIALS_CHAPTER3=OFF
      -DTUTORIALS_CHAPTER4=OFF
      -DTUTORIALS_CHAPTER5=OFF
      -DTUTORIALS_CHAPTER6=OFF
      -DTUTORIALS_CHAPTER7=OFF
      -DUSE_MSVC_RUNTIME_LIBRARY_DLL=ON

)

vcpkg_install_cmake()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled) # automatic templates
vcpkg_copy_pdbs() # automatic templates
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
###
