# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.26.4/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.26.4/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/build

# Include any dependencies generated for this target.
include CMakeFiles/expressions.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/expressions.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/expressions.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/expressions.dir/flags.make

CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o: CMakeFiles/expressions.dir/flags.make
CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o: /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/libraries/Expression/src/expression.cpp
CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o: CMakeFiles/expressions.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o -MF CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o.d -o CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o -c /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/libraries/Expression/src/expression.cpp

CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.i"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/libraries/Expression/src/expression.cpp > CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.i

CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.s"
	/usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/libraries/Expression/src/expression.cpp -o CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.s

# Object files for target expressions
expressions_OBJECTS = \
"CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o"

# External object files for target expressions
expressions_EXTERNAL_OBJECTS =

expressions: CMakeFiles/expressions.dir/libraries/Expression/src/expression.cpp.o
expressions: CMakeFiles/expressions.dir/build.make
expressions: CMakeFiles/expressions.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable expressions"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/expressions.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/expressions.dir/build: expressions
.PHONY : CMakeFiles/expressions.dir/build

CMakeFiles/expressions.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/expressions.dir/cmake_clean.cmake
.PHONY : CMakeFiles/expressions.dir/clean

CMakeFiles/expressions.dir/depend:
	cd /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/build /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/build /Users/alyonashinkareva/Desktop/cpp/complex-alyoshinkkaa/build/CMakeFiles/expressions.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/expressions.dir/depend

