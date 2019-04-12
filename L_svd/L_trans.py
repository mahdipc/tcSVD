# -*- coding: utf-8 -*-
"""
Created on Thu Apr 26 10:46:08 2018

@author: lsj
"""
import numpy as np
from numpy import *
from scipy.fftpack import fft,ifft,dct,idct

def dct_trans(y):
    n = max(y.shape)
    X = y
    a = zeros((1, 1, n))
    I = eye(n)
    C=dct(I, axis = 0, norm = 'ortho')
    Z = diag(ones(n-1), 1)
    W = diag(C[:,0])
#   b = np.linalg.inv(W)*C*(Z+I)*X
    b = np.dot(np.dot(np.dot(np.linalg.inv(W),C),(Z+I)),X)
    for i in range(n):
        a[0, 0, i] = b[i]
    return a
    
    
def idct_trans(y):
    n = max(y.shape)
    X = y
    a = zeros((1, 1, n))
    I = eye(n)
    C=idct(I, axis = 0, norm = 'ortho')
    Z = diag(ones(n-1), 1)
    W = diag(C[:,0])
#    b = np.linalg.inv(I+Z)*(C.T*(W*X))
    b = np.dot(np.linalg.inv(I+Z), np.dot(C.T,np.dot(W,X)))
    for i in range(n):
        a[0, 0, i] = b[i]
    return a

def my_dct(A):
    [n1, n2, n3] = A.shape
    a = zeros((n1, n2, n3))
    for i in range(n1):
        for j in range(n2):
            g = dct_trans(A[i, j, :])
            a[i, j, :] = g
    return a
def my_idct(A):
    [n1, n2, n3] = A.shape
    a = zeros((n1, n2, n3))
    for i in range(n1):
        for j in range(n2):
            g = idct_trans(A[i, j, :])
            a[i, j, :] = g
    return a
    
def my_fft(A):
    a = fft(A, axis = -1)
    return a
def my_ifft(A):
    a = ifft(A, axis = -1)
    return a



def trans(A, flag = 'fft'):
    [n1, n2, n3] = A.shape
    a = np.zeros((n1, n2, n3))
    if flag == 'fft':
        a = my_fft(A)
#        a = scipy.fftpack.fft(A, axis = -1)
    elif flag  == 'dct':
        a = my_dct(A)
#        print(a.dtype, flag)
    return a
    
    
def invtrans(A, flag = 'fft'):
    [n1, n2, n3] = A.shape
    a = np.zeros((n1, n2, n3))
    if flag  == 'fft':
        a = my_ifft(A)
#        a = scipy.fftpack.ifft(A, axis = -1)
    elif flag == 'dct':
        a = my_idct(A)
#        print(a.dtype, flag)        
    return a
    
