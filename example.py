"""
An example calling the cython wrapper
"""
import numpy as np
from calculate import example_calculate


def example_main():
    """
    Example call to the cython function
    """
    # this dataype is `dtype('int64')` by default
    input_data_1d = np.array([1, 2, 3])
    input_data_2d = np.array([[10, 20], [30, 40]])

    output_2d, output_1d = example_calculate(
        input_data_2d,
        input_data_1d)

    print(f"1d: {output_1d}\n2d: {output_2d}")

if __name__ == "__main__":

    example_main()
