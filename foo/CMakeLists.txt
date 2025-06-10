add_library(foo_lib STATIC
    foo.cu
    foo.cuh
)

target_link_libraries(foo_lib
    PUBLIC
        CUDA::cudart
        Thrust
)

target_include_directories(foo_lib
    PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}
)

target_compile_options(foo_lib
    PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
        --extended-lambda
        -Wno-deprecated-gpu-targets
>)
