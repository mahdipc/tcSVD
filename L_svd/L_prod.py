# -*- coding: utf-8 -*-
"""
Created on Thu Apr 26 10:43:49 2018

@author: lsj
"""
import numpy as np
from numpy import *
from L_trans import trans,invtrans
def L_prod(A, B, flag = 'fft'):
    [a1, a2, a3] = A.shape
    [b1, b2, b3] = B.shape
    A = trans(A, flag)
    B = trans(B, flag)
    C = np.zeros((a1,b2,b3), dtype = complex)
    for i in arange(b3):
        C[:, :,i] = np.dot(A[:, :, i], B[:, :, i])
    C = invtrans(C, flag)
    return C