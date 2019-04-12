# -*- coding: utf-8 -*-
"""
Created on Wed May  2 11:10:57 2018

@author: lsj
"""
import numpy as np
from numpy import *

from scipy.fftpack import fft
from L_trans import *
from L_prod import L_prod
from alter_min_LS_one_step import *
from numpy import linalg as LA
import scipy.io as sio
#data = sio.loadmat('./video.mat')
#T = data['T']
#[m, n, k] = T.shape

'''parameter setting'''
'''for reproducible results'''
m = 25
n = 25
k = 20
r = 5
'''
%low-tubal-rank tensor
%T = rand(m,n,k);  %a ranom tensor: m * n * k
%T = t_svd_threshold(T,r);  %make it to be tubal-rank = r
'''
T = L_prod(rand(m, r, k),rand(r, n, k))

T_f = my_fft(T)
T_omega = zeros((m, n, k))

omega = rand(m, n, k)<=0.8
T_omega = omega*T
T_omega_f = my_fft(T_omega)
omega_f = my_fft(omega)

Y = rand(r, n, k)
Y_f = my_fft(Y)
Y_f_trans = zeros((n, r, k), dtype = complex)
X_f = zeros((m, r, k), dtype = complex)
T_omega_f_trans  = zeros((n, m, k), dtype = complex)
omega_f_trans = zeros((n, m, k), dtype = complex)

for i in range(k):
    Y_f_trans[:, :, i] = Y_f[:, :, i].T
    T_omega_f_trans[:, :, i] = T_omega_f[:, :, i].T
    omega_f_trans[:, :, i] = omega_f[:, :, i].T

iteration = 1;

while iteration<=15:
    print('Sampling--', 0.5, '---Round--', iteration);
    X_f_trans = alter_min_LS_one_step(T_omega_f_trans, omega_f_trans*1/k, Y_f_trans)
    for i in range(k):
#        print(X_f_trans[:, :, i].shape)
        X_f[:, :, i] = X_f_trans[:, :, i].T
#'''% Given X, do LS to get Y'''
    Y_f = alter_min_LS_one_step(T_omega_f, omega_f*1/k, X_f)
    for i in range(k):
        Y_f_trans[:, :, i] = Y_f[:, :, i].T
    iteration = iteration + 1
'''%The relative error:'''
temp = 0
X_est = ifft(X_f, axis = -1)
Y_est = ifft(Y_f, axis = -1)
T_est = L_prod(X_est,Y_est,flag = 'fft')

temp = T-T_est
error = LA.norm(temp[:])/LA.norm(T[:])
print('error:', error)