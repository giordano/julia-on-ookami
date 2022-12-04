// Based on
// * <https://github.com/esiegmann/Ookami/blob/main/ExampleCodes/doesitvectorize/test.cc>
// * <https://www.stonybrook.edu/commcms/ookami/support/faq/Vectorization_Example.php>
// by Eva Siegmann.

#include <cstddef>
#include <cmath>

#ifdef __cplusplus
extern "C" {
#endif

void Xsimple(size_t n, const double* __restrict__ x, double* __restrict__ y) {
  for (size_t i=0; i<n; i++) y[i] = 2.0*x[i] + 3.0*x[i]*x[i];
}

void Xrecip(size_t n, const double* __restrict__ x, double* __restrict__ y) {
  for (size_t i=0; i<n; i++) y[i] = 1.0/x[i];
}

void Xsqrt(size_t n, const double* __restrict__ x, double* __restrict__ y) {
  for (size_t i=0; i<n; i++) y[i] = std::sqrt(x[i]);
}

void Xexp(size_t n, const double* __restrict__ x, double* __restrict__ y) {
  for (size_t i=0; i<n; i++) y[i] = std::exp(x[i]);
}

void Xsin(size_t n, const double* __restrict__ x, double* __restrict__ y) {
  for (size_t i=0; i<n; i++) y[i] = std::sin(x[i]);
}

void Xpow(size_t n, const double* __restrict__ x, double* __restrict__ y) {
  for (size_t i=0; i<n; i++) y[i] = std::pow(x[i],0.55);
}

#ifdef __cplusplus
}
#endif
