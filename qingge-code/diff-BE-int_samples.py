#!/usr/bin/env python
from __future__ import print_function


"""
Compare the output from "compute_int_samples.py" to output
from "compute_int_samples_v0.py".
They should be almost exactly the same, except that 
compute_int_samples may compute more hkls.
hkls in compute_int_samples_v0 is hand-picked.
"""

import numpy as np

def diff(path1, path2):
    data1 = np.loadtxt(path1)
    data2 = np.loadtxt(path2)
    res = False
    for i, item1 in enumerate(data1):
        if i >= len(data2): break
        item2 = data2[i]
        if not np.allclose(item1, item2, atol=2e-3):
            print(item1, item2)
            res = True
        continue
    return res

if __name__ == '__main__':
    if diff('int_samples_v0.dat', 'int_samples.dat'):
        import sys;  sys.exit(1)
