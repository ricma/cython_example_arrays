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
    input_data_1d = np.array([1, 2, 3])
    input_data_2d = np.array([[10, 20], [30, 40]])

    # FIXME: We call the dbg version for now
    # To use that:
    # % ulimit -c unlimited
    # % python3 example.py
    #   --> should core dump
    # % gdb python3 core
    # should start the debugger and get you where the exception happened.
    output_2d, output_1d = example_calculate_dbg(
        input_data_2d,
        input_data_1d)

    print(f"1d: {output_1d}\n2d: {output_2d}")

if __name__ == "__main__":

    example_main()
