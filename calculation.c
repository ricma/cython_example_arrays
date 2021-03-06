#include "calculation.h"

/**
 * Fill given array with numbers
 */
int example_calculation(my_uint N1, my_uint M1, my_uint *data1_in,
                        my_uint N2, my_uint *data2_in,
                        my_uint N3, my_uint M3, my_uint *data3_out,
                        my_uint N4, my_uint *data4_out)
{
  if (N1 < N3 | M1 < M3 | N2 < N4) {
    return -1;
  }

  for (unsigned int i=0; i<N3; ++i)
    {
      for (unsigned int j=0; j<M3; ++j)
        {
          data3_out[M3 * i + j] = (
            data1_in[M1 * i + j] +
            lround(fabs(100 * sin(1.0 * i + j))));
        }
    }

  for (unsigned int i=0; i<N4; ++i)
    {
      data4_out[i] = (
        data2_in[i] +
        lround(fabs(120 * sin(1.4 * i))));
    }

  return 0;
}
