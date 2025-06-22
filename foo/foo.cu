#include "foo.cuh"

#include <thrust/device_vector.h>
#include <thrust/random.h>
#include <thrust/sort.h>

#include <nvtx3/nvtx3.hpp>

const size_t DEFAULT_POOL_SIZE = 1 << 28;

struct BoidsData::BoidsDataPimpl {
    thrust::device_vector<float> pos;
};

BoidsData::BoidsData() :
    m_pimpl(std::make_unique<BoidsDataPimpl>())
{
    init(DEFAULT_POOL_SIZE);
}

// For PIMPL with unique_ptr destructor must be defined in source, otherwise incomplete type when header auto-generates.
BoidsData::~BoidsData() = default;

void BoidsData::init(size_t n) {
    nvtx3::scoped_range loop{"BoidsData::init"};

    BoidsDataPimpl* pimpl = m_pimpl.get();
    thrust::tabulate(
        pimpl->pos.begin(),
        pimpl->pos.end(),
        [] __device__ (size_t i) {
            thrust::default_random_engine rng;
            thrust::uniform_real_distribution<float> dist(0, 1000);
            rng.discard(i); // FIXME confirm usage of discard
            return dist(rng);
        }
    );
}

void BoidsData::step() {
    nvtx3::scoped_range loop{"BoidsData::step"};

    BoidsDataPimpl* pimpl = m_pimpl.get();
    thrust::transform(
        pimpl->pos.begin(),
        pimpl->pos.end(),
        pimpl->pos.begin(),
        [] __device__ (float v) {
            return v * 2;
        }
    );
}
