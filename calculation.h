#ifndef __calculation_h_9dnckiwnglrtmgld_
#define __calculation_h_9dnckiwnglrtmgld_

#include <stdint.h>
#include <math.h>

// a shorthand to play around with it easily
typedef uint32_t my_uint;

/**
 * Fill given array with numbers
 */
int example_calculation(my_uint N1, my_uint M1, my_uint *data1_in,
                        my_uint N2, my_uint *data2_in,
                        my_uint N3, my_uint M3, my_uint *data3_out,
                        my_uint N4, my_uint *data4_out);

#endif  /* __calculation_h_9dnckiwnglrtmgld_ */
