# -*- coding: utf-8 -*-
"""
Created on Thu Apr 26 10:53:05 2018

@author: lsj
"""
#from L_trans import trans,invtrans
# from L_trans import *
from numpy import *
import numpy as np
from numpy import linalg as la
def L_svd(M, flag = 'fft'):
	[n1 ,n2 ,n3] = M.shape
	D = zeros((n1 ,n2 ,n3), dtype = complex)
	D = trans(M, flag)
#	print(D)
# 	print(flag)
#   	D = fft(M, axis = -1)
#   	print(D.shape)    
	Uf = zeros((n1,n1,n3), dtype = complex)
	Thetaf = zeros((n1,n2,n3), dtype = complex)
	Vf = zeros((n2,n2,n3), dtype = complex)	

	for i in range(n3):
		temp_U ,temp_Theta, temp_V = la.svd(D[: ,: ,i], full_matrices=True);
		Uf[: ,: ,i] = temp_U;
		Thetaf[:n2, :n2, i] = np.diag(temp_Theta)
		Vf[:, :, i] = temp_V;
	U = zeros((n1,n1,n3))
	Theta = zeros((n1,n2,n3))
	V = zeros((n2,n2,n3))
#	U = ifft(Uf, axis = 2).real
#	Theta = ifft(Thetaf, axis = -1).real
#	V = ifft(Vf, axis = -1).real
	U = invtrans(Uf, flag).real
	Theta = invtrans(Thetaf, flag).real
	V = invtrans(Vf, flag).real
	return U, Theta, V