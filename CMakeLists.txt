cmake_minimum_required(VERSION 3.15 FATAL_ERROR)

# Global project settings
project(imgui_cmake LANGUAGES CXX CUDA)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)

# Setup CUDA/Thrust, build for active system
find_package(CUDAToolkit REQUIRED)
find_package(Thrust REQUIRED)
thrust_create_target(Thrust)

set(CMAKE_CUDA_ARCHITECTURES native)
set(CUDA_SEPARABLE_COMPILATION ON)

# Fetch libs for ImGui and GLAD (and GLFW)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
find_package(imgui REQUIRED)
add_subdirectory(glad)

# Add library to test linkage
add_library(foo_lib STATIC
    foo.cu
)

target_link_libraries(foo_lib
    PUBLIC
        CUDA::cudart
        Thrust
)

target_compile_options(foo_lib
    PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
        --extended-lambda
        -Wno-deprecated-gpu-targets
>)

# Main app using library
add_executable(main_app
    main.cu
)

target_link_libraries(main_app
    PRIVATE
        imgui_static
        foo_lib
        glad
)

target_compile_options(main_app
    PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
        --extended-lambda
        -Wno-deprecated-gpu-targets
>)
