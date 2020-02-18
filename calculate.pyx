"""
Cython wrapper around code in calculation.c
"""
import cython
import numpy as np
cimport numpy as np

ctypedef np.npy_uint32 UINT_t

cdef extern from "calculation.h":

  int example_calculation(
      UINT_t N1, UINT_t M1, UINT_t *data1_in,
      UINT_t N2, UINT_t *data2_in,
      UINT_t N3, UINT_t M3, UINT_t *data3_out,
      UINT_t N4, UINT_t *data4_out) except +


# TODO: Declare return type to return multiple arrays
@cython.boundscheck(True) # turn off bounds-checking for entire function
@cython.wraparound(True)  # turn off negative index wrapping for entire function
def example_calculate(
        np.ndarray[UINT_t, ndim=2] input_data_2d,
        np.ndarray[UINT_t, ndim=1] input_data_1d):
    """
    Example calculation

    Parameters
    ----------
    input_data_1d: ndarray, dtype np.uint32, ndim = 2
        Input data of 2-dim shape (N1, M1)
    input_data_2d: ndarray, dtype np.uint32, ndim = 1
        Input data of 1-dim shape (N2, )

    Returns
    -------
    output_data_2d: ndarray, dtype np.uint32, ndim = 2
        Output data of 2-dim shape (N3, M3)
    output_data_1d: ndarray, dtype np.uint32, ndim = 1
        Output data of 1-dim shape (N4, )
    """
    # calculate the size of the output arrays
    cdef UINT_t N1, M1, N2, N3, N4, M4

    N1 = len(input_data_2d)
    M1 = len(input_data_2d[0])
    N2 = len(input_data_1d)
    # for sake of simplicity here -- use the same sizes
    N3 = N1
    M3 = M1
    N4 = N2

    # allocate output memory
    cdef np.ndarray[UINT_t, ndim=1] output_data_1d = np.zeros(
        (N4, ), dtype=np.uint32)
    cdef np.ndarray[UINT_t, ndim=2] output_data_2d = np.zeros(
        (N3, M3), dtype=np.uint32)

    # call the C-code
    example_calculation(
        N1, M1, <UINT_t *> input_data_2d.data,
        N2, <UINT_t *> input_data_1d.data,
        N3, M3, <UINT_t *> output_data_2d.data,
        N4, <UINT_t *> output_data_1d.data)

    return (output_data_1d, output_data_2d)
