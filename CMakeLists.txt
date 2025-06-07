cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Global project settings
project(imgui_cmake LANGUAGES CXX CUDA)

include(cmake/FetchGLFW.cmake)
include(cmake/FetchImgui.cmake)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)

set(CMAKE_CUDA_ARCHITECTURES "native")

find_package(CUDAToolkit REQUIRED)
find_package(Thrust REQUIRED)

thrust_create_target(Thrust)


# Add library to test linkage
add_library(foo_lib STATIC
    foo.cu
)

target_link_libraries(foo_lib
    PUBLIC
        CUDA::cudart
        Thrust
)

set_target_properties(foo_lib
    PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON
)


# Main app using library
add_executable(main_app
    main.cu
)

set_target_properties(main_app
    PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON
)

target_link_libraries(main_app
    PRIVATE
        imgui_static
        foo_lib
)
