#include "calculation.h"

/**
 * Fill given array with numbers
 */
int example_calculation(int N1, int M1, int *data1_in,
                        int N2, int *data2_in,
                        int N3, int M3, int *data3_out,
                        int N4, int *data4_out)
{
  // FIXME: We are not using the input array here ...
  // but it is just an example anyway ...
  for (int i=0; i<N3; ++i)
    {
      for (int j=0; j<M3; ++i)
        {
          data3_out[M3 * i + j] = lround(sin(1.0 * i + j));
        }
    }

  for (int i=0; i<N4; ++i)
    {
      data4_out[i] = lround(sin(1.4 * i));
    }

  return 0;
}
