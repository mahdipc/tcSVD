# -*- coding: utf-8 -*-
"""
Created on Fri May  4 17:28:28 2018

@author: lsj
"""
from numpy import *
import numpy as np
def arr_to_circul(x):
    n = len(x)
    X = zeros((n, n), dtype = complex)
    for i in range(n):
        for j in range(n):
            k = i + j
            s = k
            if k>n-1:
                s = k-n
            X[i, s] = x[j]
    return X

m = np.arange(10)
#print(m.shape)
#M = arr_to_circul(m)
#print(M)
##
arr_to_circul(m)
