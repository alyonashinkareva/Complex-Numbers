project(Expression)

add_library(${PROJECT_NAME} include/${PROJECT_NAME}.h      src/${PROJECT_NAME}.cpp
                            include/complex.h               src/complex.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC include)


add_library(small5::${PROJECT_NAME} ALIAS ${PROJECT_NAME})


find_package(Catch2 3 REQUIRED)
add_executable(tests tests/tests.cpp)
target_link_libraries(tests PRIVATE Catch2::Catch2WithMain small5::${PROJECT_NAME})


if(COMPILE_OPTS)
    target_compile_options(${PROJECT_NAME} PUBLIC ${COMPILE_OPTS})
    target_link_options(${PROJECT_NAME} PUBLIC ${LINK_OPTS})

    target_compile_options(tests PUBLIC ${COMPILE_OPTS})
    target_link_options(tests PUBLIC ${LINK_OPTS})
endif()