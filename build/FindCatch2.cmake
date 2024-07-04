########## MACROS ###########################################################################
#############################################################################################

function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()


macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS FRAMEWORKS_DIRS)
    if(APPLE)
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAMES ${_FRAMEWORK} PATHS ${FRAMEWORKS_DIRS} CMAKE_FIND_ROOT_PATH_BOTH)
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${FRAMEWORKS_DIRS}")
            endif()
        endforeach()
    endif()
endmacro()


function(conan_package_library_targets libraries package_libdir deps out_libraries out_libraries_target build_type package_name)
    unset(_CONAN_ACTUAL_TARGETS CACHE)
    unset(_CONAN_FOUND_SYSTEM_LIBS CACHE)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAMES ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            list(APPEND _out_libraries ${CONAN_FOUND_LIBRARY})
            if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
                # Create a micro-target for each lib/a found
                string(REGEX REPLACE "[^A-Za-z0-9.+_-]" "_" _LIBRARY_NAME ${_LIBRARY_NAME})
                set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
                if(NOT TARGET ${_LIB_NAME})
                    # Create a micro-target for each lib/a found
                    add_library(${_LIB_NAME} UNKNOWN IMPORTED)
                    set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
                    set(_CONAN_ACTUAL_TARGETS ${_CONAN_ACTUAL_TARGETS} ${_LIB_NAME})
                else()
                    conan_message(STATUS "Skipping already existing target: ${_LIB_NAME}")
                endif()
                list(APPEND _out_libraries_target ${_LIB_NAME})
            endif()
            conan_message(STATUS "Found: ${CONAN_FOUND_LIBRARY}")
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            list(APPEND _out_libraries_target ${_LIBRARY_NAME})
            list(APPEND _out_libraries ${_LIBRARY_NAME})
            set(_CONAN_FOUND_SYSTEM_LIBS "${_CONAN_FOUND_SYSTEM_LIBS};${_LIBRARY_NAME}")
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()

    if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
        # Add all dependencies to all targets
        string(REPLACE " " ";" deps_list "${deps}")
        foreach(_CONAN_ACTUAL_TARGET ${_CONAN_ACTUAL_TARGETS})
            set_property(TARGET ${_CONAN_ACTUAL_TARGET} PROPERTY INTERFACE_LINK_LIBRARIES "${_CONAN_FOUND_SYSTEM_LIBS};${deps_list}")
        endforeach()
    endif()

    set(${out_libraries} ${_out_libraries} PARENT_SCOPE)
    set(${out_libraries_target} ${_out_libraries_target} PARENT_SCOPE)
endfunction()


########### FOUND PACKAGE ###################################################################
#############################################################################################

include(FindPackageHandleStandardArgs)

conan_message(STATUS "Conan: Using autogenerated FindCatch2.cmake")
set(Catch2_FOUND 1)
set(Catch2_VERSION "3.3.2")

find_package_handle_standard_args(Catch2 REQUIRED_VARS
                                  Catch2_VERSION VERSION_VAR Catch2_VERSION)
mark_as_advanced(Catch2_FOUND Catch2_VERSION)

set(catch2_COMPONENTS catch2::catch2_with_main catch2::_catch2)

if(Catch2_FIND_COMPONENTS)
    foreach(_FIND_COMPONENT ${Catch2_FIND_COMPONENTS})
        list(FIND catch2_COMPONENTS "catch2::${_FIND_COMPONENT}" _index)
        if(${_index} EQUAL -1)
            conan_message(FATAL_ERROR "Conan: Component '${_FIND_COMPONENT}' NOT found in package 'catch2'")
        else()
            conan_message(STATUS "Conan: Component '${_FIND_COMPONENT}' found in package 'catch2'")
        endif()
    endforeach()
endif()

########### VARIABLES #######################################################################
#############################################################################################


set(catch2_INCLUDE_DIRS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2_INCLUDE_DIR "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2_INCLUDES "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2_RES_DIRS )
set(catch2_DEFINITIONS )
set(catch2_LINKER_FLAGS_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)
set(catch2_COMPILE_DEFINITIONS )
set(catch2_COMPILE_OPTIONS_LIST "" "")
set(catch2_COMPILE_OPTIONS_C "")
set(catch2_COMPILE_OPTIONS_CXX "")
set(catch2_LIBRARIES_TARGETS "") # Will be filled later, if CMake 3
set(catch2_LIBRARIES "") # Will be filled later
set(catch2_LIBS "") # Same as catch2_LIBRARIES
set(catch2_SYSTEM_LIBS )
set(catch2_FRAMEWORK_DIRS )
set(catch2_FRAMEWORKS )
set(catch2_FRAMEWORKS_FOUND "") # Will be filled later
set(catch2_BUILD_MODULES_PATHS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib/cmake/conan-official-catch2-targets.cmake")

conan_find_apple_frameworks(catch2_FRAMEWORKS_FOUND "${catch2_FRAMEWORKS}" "${catch2_FRAMEWORK_DIRS}")

mark_as_advanced(catch2_INCLUDE_DIRS
                 catch2_INCLUDE_DIR
                 catch2_INCLUDES
                 catch2_DEFINITIONS
                 catch2_LINKER_FLAGS_LIST
                 catch2_COMPILE_DEFINITIONS
                 catch2_COMPILE_OPTIONS_LIST
                 catch2_LIBRARIES
                 catch2_LIBS
                 catch2_LIBRARIES_TARGETS)

# Find the real .lib/.a and add them to catch2_LIBS and catch2_LIBRARY_LIST
set(catch2_LIBRARY_LIST Catch2Maind Catch2d)
set(catch2_LIB_DIRS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib")

# Gather all the libraries that should be linked to the targets (do not touch existing variables):
set(_catch2_DEPENDENCIES "${catch2_FRAMEWORKS_FOUND} ${catch2_SYSTEM_LIBS} ")

conan_package_library_targets("${catch2_LIBRARY_LIST}"  # libraries
                              "${catch2_LIB_DIRS}"      # package_libdir
                              "${_catch2_DEPENDENCIES}"  # deps
                              catch2_LIBRARIES            # out_libraries
                              catch2_LIBRARIES_TARGETS    # out_libraries_targets
                              ""                          # build_type
                              "catch2")                                      # package_name

set(catch2_LIBS ${catch2_LIBRARIES})

foreach(_FRAMEWORK ${catch2_FRAMEWORKS_FOUND})
    list(APPEND catch2_LIBRARIES_TARGETS ${_FRAMEWORK})
    list(APPEND catch2_LIBRARIES ${_FRAMEWORK})
endforeach()

foreach(_SYSTEM_LIB ${catch2_SYSTEM_LIBS})
    list(APPEND catch2_LIBRARIES_TARGETS ${_SYSTEM_LIB})
    list(APPEND catch2_LIBRARIES ${_SYSTEM_LIB})
endforeach()

# We need to add our requirements too
set(catch2_LIBRARIES_TARGETS "${catch2_LIBRARIES_TARGETS};")
set(catch2_LIBRARIES "${catch2_LIBRARIES};")

set(CMAKE_MODULE_PATH "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib/cmake/Catch2" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib/cmake/Catch2" ${CMAKE_PREFIX_PATH})


########### COMPONENT _catch2 VARIABLES #############################################

set(catch2__catch2_INCLUDE_DIRS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2__catch2_INCLUDE_DIR "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2__catch2_INCLUDES "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2__catch2_LIB_DIRS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib")
set(catch2__catch2_RES_DIRS )
set(catch2__catch2_DEFINITIONS )
set(catch2__catch2_COMPILE_DEFINITIONS )
set(catch2__catch2_COMPILE_OPTIONS_C "")
set(catch2__catch2_COMPILE_OPTIONS_CXX "")
set(catch2__catch2_LIBS Catch2d)
set(catch2__catch2_SYSTEM_LIBS )
set(catch2__catch2_FRAMEWORK_DIRS )
set(catch2__catch2_FRAMEWORKS )
set(catch2__catch2_BUILD_MODULES_PATHS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib/cmake/conan-official-catch2-targets.cmake")
set(catch2__catch2_DEPENDENCIES )
set(catch2__catch2_LINKER_FLAGS_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)

########### COMPONENT catch2_with_main VARIABLES #############################################

set(catch2_catch2_with_main_INCLUDE_DIRS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2_catch2_with_main_INCLUDE_DIR "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2_catch2_with_main_INCLUDES "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/include")
set(catch2_catch2_with_main_LIB_DIRS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib")
set(catch2_catch2_with_main_RES_DIRS )
set(catch2_catch2_with_main_DEFINITIONS )
set(catch2_catch2_with_main_COMPILE_DEFINITIONS )
set(catch2_catch2_with_main_COMPILE_OPTIONS_C "")
set(catch2_catch2_with_main_COMPILE_OPTIONS_CXX "")
set(catch2_catch2_with_main_LIBS Catch2Maind)
set(catch2_catch2_with_main_SYSTEM_LIBS )
set(catch2_catch2_with_main_FRAMEWORK_DIRS )
set(catch2_catch2_with_main_FRAMEWORKS )
set(catch2_catch2_with_main_BUILD_MODULES_PATHS "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib/cmake/conan-official-catch2-targets.cmake")
set(catch2_catch2_with_main_DEPENDENCIES catch2::_catch2)
set(catch2_catch2_with_main_LINKER_FLAGS_LIST
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:>"
        "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:>"
)


########## FIND PACKAGE DEPENDENCY ##########################################################
#############################################################################################

include(CMakeFindDependencyMacro)


########## FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #######################################
#############################################################################################

########## COMPONENT _catch2 FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(catch2__catch2_FRAMEWORKS_FOUND "")
conan_find_apple_frameworks(catch2__catch2_FRAMEWORKS_FOUND "${catch2__catch2_FRAMEWORKS}" "${catch2__catch2_FRAMEWORK_DIRS}")

set(catch2__catch2_LIB_TARGETS "")
set(catch2__catch2_NOT_USED "")
set(catch2__catch2_LIBS_FRAMEWORKS_DEPS ${catch2__catch2_FRAMEWORKS_FOUND} ${catch2__catch2_SYSTEM_LIBS} ${catch2__catch2_DEPENDENCIES})
conan_package_library_targets("${catch2__catch2_LIBS}"
                              "${catch2__catch2_LIB_DIRS}"
                              "${catch2__catch2_LIBS_FRAMEWORKS_DEPS}"
                              catch2__catch2_NOT_USED
                              catch2__catch2_LIB_TARGETS
                              ""
                              "catch2__catch2")

set(catch2__catch2_LINK_LIBS ${catch2__catch2_LIB_TARGETS} ${catch2__catch2_LIBS_FRAMEWORKS_DEPS})

set(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH  ${CMAKE_PREFIX_PATH})

########## COMPONENT catch2_with_main FIND LIBRARIES & FRAMEWORKS / DYNAMIC VARS #############

set(catch2_catch2_with_main_FRAMEWORKS_FOUND "")
conan_find_apple_frameworks(catch2_catch2_with_main_FRAMEWORKS_FOUND "${catch2_catch2_with_main_FRAMEWORKS}" "${catch2_catch2_with_main_FRAMEWORK_DIRS}")

set(catch2_catch2_with_main_LIB_TARGETS "")
set(catch2_catch2_with_main_NOT_USED "")
set(catch2_catch2_with_main_LIBS_FRAMEWORKS_DEPS ${catch2_catch2_with_main_FRAMEWORKS_FOUND} ${catch2_catch2_with_main_SYSTEM_LIBS} ${catch2_catch2_with_main_DEPENDENCIES})
conan_package_library_targets("${catch2_catch2_with_main_LIBS}"
                              "${catch2_catch2_with_main_LIB_DIRS}"
                              "${catch2_catch2_with_main_LIBS_FRAMEWORKS_DEPS}"
                              catch2_catch2_with_main_NOT_USED
                              catch2_catch2_with_main_LIB_TARGETS
                              ""
                              "catch2_catch2_with_main")

set(catch2_catch2_with_main_LINK_LIBS ${catch2_catch2_with_main_LIB_TARGETS} ${catch2_catch2_with_main_LIBS_FRAMEWORKS_DEPS})

set(CMAKE_MODULE_PATH "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib/cmake/Catch2" ${CMAKE_MODULE_PATH})
set(CMAKE_PREFIX_PATH "/Users/alyonashinkareva/.conan/data/catch2/3.3.2/_/_/package/ba61653acba7f336b431d30962c96bae7bd2519f/lib/cmake/Catch2" ${CMAKE_PREFIX_PATH})


########## TARGETS ##########################################################################
#############################################################################################

########## COMPONENT _catch2 TARGET #################################################

if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
    # Target approach
    if(NOT TARGET catch2::_catch2)
        add_library(catch2::_catch2 INTERFACE IMPORTED)
        set_target_properties(catch2::_catch2 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
                              "${catch2__catch2_INCLUDE_DIRS}")
        set_target_properties(catch2::_catch2 PROPERTIES INTERFACE_LINK_DIRECTORIES
                              "${catch2__catch2_LIB_DIRS}")
        set_target_properties(catch2::_catch2 PROPERTIES INTERFACE_LINK_LIBRARIES
                              "${catch2__catch2_LINK_LIBS};${catch2__catch2_LINKER_FLAGS_LIST}")
        set_target_properties(catch2::_catch2 PROPERTIES INTERFACE_COMPILE_DEFINITIONS
                              "${catch2__catch2_COMPILE_DEFINITIONS}")
        set_target_properties(catch2::_catch2 PROPERTIES INTERFACE_COMPILE_OPTIONS
                              "${catch2__catch2_COMPILE_OPTIONS_C};${catch2__catch2_COMPILE_OPTIONS_CXX}")
    endif()
endif()

########## COMPONENT catch2_with_main TARGET #################################################

if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
    # Target approach
    if(NOT TARGET catch2::catch2_with_main)
        add_library(catch2::catch2_with_main INTERFACE IMPORTED)
        set_target_properties(catch2::catch2_with_main PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
                              "${catch2_catch2_with_main_INCLUDE_DIRS}")
        set_target_properties(catch2::catch2_with_main PROPERTIES INTERFACE_LINK_DIRECTORIES
                              "${catch2_catch2_with_main_LIB_DIRS}")
        set_target_properties(catch2::catch2_with_main PROPERTIES INTERFACE_LINK_LIBRARIES
                              "${catch2_catch2_with_main_LINK_LIBS};${catch2_catch2_with_main_LINKER_FLAGS_LIST}")
        set_target_properties(catch2::catch2_with_main PROPERTIES INTERFACE_COMPILE_DEFINITIONS
                              "${catch2_catch2_with_main_COMPILE_DEFINITIONS}")
        set_target_properties(catch2::catch2_with_main PROPERTIES INTERFACE_COMPILE_OPTIONS
                              "${catch2_catch2_with_main_COMPILE_OPTIONS_C};${catch2_catch2_with_main_COMPILE_OPTIONS_CXX}")
    endif()
endif()

########## GLOBAL TARGET ####################################################################

if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
    if(NOT TARGET catch2::catch2)
        add_library(catch2::catch2 INTERFACE IMPORTED)
    endif()
    set_property(TARGET catch2::catch2 APPEND PROPERTY
                 INTERFACE_LINK_LIBRARIES "${catch2_COMPONENTS}")
endif()

########## BUILD MODULES ####################################################################
#############################################################################################
########## COMPONENT _catch2 BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${catch2__catch2_BUILD_MODULES_PATHS})
    include(${_BUILD_MODULE_PATH})
endforeach()
########## COMPONENT catch2_with_main BUILD MODULES ##########################################

foreach(_BUILD_MODULE_PATH ${catch2_catch2_with_main_BUILD_MODULES_PATHS})
    include(${_BUILD_MODULE_PATH})
endforeach()
