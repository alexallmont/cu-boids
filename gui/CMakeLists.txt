add_executable(cu-boids
    main.cpp
)

target_link_libraries(cu-boids
    PRIVATE
        imgui_static
        foo_lib
        glad
)

target_compile_options(cu-boids
    PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
        --extended-lambda
        -Wno-deprecated-gpu-targets
>)
