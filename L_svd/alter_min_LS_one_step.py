# -*- coding: utf-8 -*-
"""
Created on Thu May  3 16:59:43 2018

@author: lsj
"""
import numpy as np
from numpy import *
from blkdiag import blkdiag
from arr_to_circul import arr_to_circul
def alter_min_LS_one_step(T_omega_f, omega_f, X_f):
    
    [m, n, k] = T_omega_f.shape
    [m, r, k] = X_f.shape
    
    Y_f = zeros((r, n, k), dtype = complex)
    X_f_new = X_f[:, :, 0]
#    print(squeeze(X_f[:, :, 0+1]).shape)
    
    for i in range(k-1):
        X_f_new = blkdiag(X_f_new, X_f[:, :, 1+i])
    residual = 0
    tensor_V = zeros((k*m, 1), dtype = complex)
    temp_Y_f = zeros((r*k, 1), dtype = complex)
    for i in range(n):
        for j in range(k):
            tensor_V[j*m : (j+1)*m] = squeeze(T_omega_f[:, i, j]).reshape((m, 1))
        omega_f_3D = zeros((k, k, m), dtype = complex)
        omega_f_new = zeros((k*m, k*m), dtype = complex)
        for j in range(m):
            temp = arr_to_circul(squeeze(omega_f[j, i, :]))
            omega_f_3D[:, :, j] = temp.T
        for a in range(k):
            for b in range(k):
                for c in range(m):
                    row = a*m+c
                    col = b*m+c
                    omega_f_new[row, col] = omega_f_3D[a, b, c]
#        print(omega_f_new.shape, X_f_new.shape)
                    
        temp = np.dot(omega_f_new, X_f_new)
#        print(temp.shape, tensor_V.shape)
        temp_Y_f,resid,rank,sigma = np.linalg.lstsq(temp, tensor_V)
#        print(temp_Y_f.shape)
        for j in range(k):
            Y_f[:,i, j] = squeeze(temp_Y_f[j*r:(j+1)*r])
    return Y_f