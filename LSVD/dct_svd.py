#!/usr/bin/env python3
#_*_coding:utf-8_*_
##################################
#'fourth tensor svd base on dct'
# the size of tensor t is  m*n*k*l
##################################
__author__='haili'
import os
import numpy as np
from  scipy.fftpack import dct,idct
import sys
def svd(t):
    t_size=t.shape
    l=t_size[0]
    k=t_size[1]
    m=t_size[2]
    n=t_size[3]
    # take fft
    t=dct(t,axis=1,norm='ortho')
    t=dct(t,axis=0,norm='ortho')
    # take svd
    if m<n:
        S=np.zeros((l,k,m,m))
    else:
        S=np.zeros((l,k,n,n))
    U=np.zeros((l,k,m,m))
    V=np.zeros((l,k,n,n))
    for i in range(l): 
        for j in range(k):
            u,s,v=np.linalg.svd(t[i][j])
            U[i][j]=u
            V[i][j]=v
            S[i][j]=np.diag(s)
#    print('++++++++\n',S)
#    print('++++++++\n',U)
#    print('++++++++\n',V)
    #take idct
    U=idct(U,axis=1,norm='ortho')
    U=idct(U,axis=0,norm='ortho')
    V=idct(V,axis=1,norm='ortho')
    V=idct(V,axis=0,norm='ortho')
    S=idct(S,axis=1,norm='ortho')
    S=idct(S,axis=0,norm='ortho')
    return [U,S,V]
