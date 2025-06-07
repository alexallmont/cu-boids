#include "foo.cuh"

#include <thrust/copy.h>
#include <thrust/device_vector.h>
#include <thrust/sort.h>

void foo_sort_floats(thrust::host_vector<float>& h_vec) {
    // Sort on device
    thrust::device_vector<float> d_vec = h_vec;
    thrust::sort(d_vec.begin(), d_vec.end());

    // Copy back to host
    thrust::copy(d_vec.begin(), d_vec.end(), h_vec.begin());
}
