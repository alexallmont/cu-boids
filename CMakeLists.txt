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

# Fetch libs for ImGui (which brings in GLFW), and GLAD in 3rdparty
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
find_package(imgui REQUIRED)
add_subdirectory(3rdparty)

add_subdirectory(foo)
add_subdirectory(gui)
