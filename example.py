"""
An example calling the cython wrapper
"""
import numpy as np
from calculate import example_calculate

# This is the version compiled with debug symbols and w/o optimizations
from calculate_dbg import example_calculate as example_calculate_dbg


def example_main():
    """
    Example call to the cython function
    """
    # this dataype is `dtype('int64')` by default
    # which is `long` in C.
    input_data_1d = np.array(30 * [1], dtype=np.uint32)
    input_data_2d = np.array([[10, 20], [30, 40]], dtype=np.uint32)

    # FIXME: We call the dbg version for now
    # To use that:
    # % ulimit -c unlimited
    # % python3 example.py
    #   --> should core dump
    # % gdb python3 core
    # should start the debugger and get you where the exception happened.
    # you can then type at the gdb prompt:
    # (gdb) run example.py
    # and it should drop you to where the SIGSEGV is raised
    output_2d, output_1d = example_calculate_dbg(
        input_data_2d,
        input_data_1d)

    # test against the expected output:
    output_1d_expected = np.zeros(output_1d.shape, dtype=np.uint32)
    for i in range(output_1d_expected.shape[0]):
        output_1d_expected[i] = int(np.round(np.abs(120 * np.sin(1.4 * i))))
    output_1d_expected += input_data_1d[:len(output_1d)]

    output_2d_expected = np.zeros(output_2d.shape, dtype=np.uint32)
    for i in range(output_2d_expected.shape[0]):
        for j in range(output_2d_expected.shape[0]):
            output_2d_expected[i, j] = int(np.round(np.abs(100 * np.sin(i + j))))
    output_2d_expected += input_data_2d[:output_2d.shape[0],
                                        :output_2d.shape[1]]

    np.testing.assert_array_almost_equal(
        output_2d, output_2d_expected,
        err_msg="2d array not as expected!")

    np.testing.assert_array_almost_equal(
        output_1d, output_1d_expected,
        err_msg="1d array not as expected!")

    print(f"2d: {output_2d}\n1d: {output_1d}")

if __name__ == "__main__":

    example_main()
