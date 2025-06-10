#ifndef FOO_CUH
#define FOO_CUH

#include <thrust/host_vector.h>

extern void foo_sort_floats(thrust::host_vector<float>& h_vec);

#endif // FOO_CUH
