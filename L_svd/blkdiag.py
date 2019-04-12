# -*- coding: utf-8 -*-
"""
Created on Sat May  5 14:57:09 2018

@author: lsj
"""
from numpy import *
import numpy as np
def blkdiag(X, x):
    [n1, n2] = X.shape
    [m1, m2] = x.shape
    row = n1 + m1
    col = n2 + m2
    Xx = zeros((row, col), dtype = complex)
    Xx[0:n1, 0:n2] = X
    Xx[n1:, n2:] = x
    return Xx
#A = np.arange(25).reshape((5, 5))
#print(A)
#a = np.arange(5*3).reshape((5, 3))   
##Aa = blkdiag(A, a)
#print(np.dot(A,a))