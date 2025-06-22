#ifndef FOO_CUH
#define FOO_CUH

#include <memory>

class BoidsData {
public:
    BoidsData();
    ~BoidsData();

    void init(size_t n);
    void step();

private:
    struct BoidsDataPimpl;

    std::unique_ptr<BoidsDataPimpl> m_pimpl;
};

#endif // FOO_CUH
