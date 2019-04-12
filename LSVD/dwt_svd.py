#!/usr/bin/env python3
#_*_coding:utf-8_*_
##################################
#'fourth tensor svd base on dwt'
# the size of tensor t is  m*n*k*l
##################################
__author__='haili'
import os
import numpy as np
import pywt
import sys
def svd(t):
    # take dwt
    coe_3=pywt.dwt(t,'db4',axis=1)
    t=np.concatenate((coe_3[0],coe_3[1]),axis=1) 
    coe_4=pywt.dwt(t,'db4',axis=0)
    t=np.concatenate((coe_4[0],coe_4[1]),axis=0)
    # take svd
    t_size=t.shape
    l=t_size[0]
    k=t_size[1]
    m=t_size[2]
    n=t_size[3]
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
    #take idWt
    #---------U_idwt----------------------------
    U=pywt.idwt(U[:,0:k//2,:,:],U[:,k//2:k,:,:],'db4',axis=1)
    U=pywt.idwt(U[0:l//2,:,:,:],U[l//2:l,:,:,:],'db4',axis=0)

    #---------S_idwt----------------------------
    S=pywt.idwt(S[:,0:k//2,:,:],S[:,k//2:k,:,:],'db4',axis=1)
    S=pywt.idwt(S[0:l//2,:,:,:],S[l//2:l,:,:,:],'db4',axis=0)

    #---------V_idwt----------------------------
    V=pywt.idwt(V[:,0:k//2,:,:],V[:,k//2:k,:,:],'db4',axis=1)
    V=pywt.idwt(V[0:l//2,:,:,:],V[l//2:l,:,:,:],'db4',axis=0)
    return [U,S,V]
