#!/usr/bin/env python3
#_*_coding:utf-8_*_
#########################################
# 'fourth tensor svd base on fft'
# the size of tensor t is  m*n*k*l
#########################################
__author__='haili'
import os
import numpy as np
import sys
def svd(t):
    t_size=t.shape
    l=t_size[0]
    k=t_size[1]
    m=t_size[2]
    n=t_size[3]
    # take fft
    t=np.fft.fft(t,axis=1)
    t=np.fft.fft(t,axis=0)
    # take svd
    if m<n:
        S=np.zeros((l,k,m,m))
    else:
        S=np.zeros((l,k,n,n))
    U=np.zeros((l,k,m,m),dtype=complex)
    V=np.zeros((l,k,n,n),dtype=complex)
    for i in range(l): 
        for j in range(k):
            u,s,v=np.linalg.svd(t[i][j])
            U[i][j]=u
            V[i][j]=v
            S[i][j]=np.diag(s)
#    print('++++++++\n',S)
#    print('++++++++\n',U)
#    print('++++++++\n',V)
    #take ifft
    U=np.fft.ifft(U,axis=1)
    U=np.fft.ifft(U,axis=0)
    V=np.fft.ifft(V,axis=1)
    V=np.fft.ifft(V,axis=0)
    S=np.fft.ifft(S,axis=1)
    S=np.fft.ifft(S,axis=0)
    return [U,S,V]
