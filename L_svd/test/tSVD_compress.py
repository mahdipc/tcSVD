# -*- coding: utf-8 -*-
"""
Created on Fri Aug 31 09:29:49 2018

@author: dayangyang
"""
import matplotlib.pyplot as plt
import numpy as np
import sys
sys.path.append("..")
from L_svd import L_svd
from L_prod import L_prod
from L_svd_compress import L_svd_compress
from L_svd_compress_tub import L_svd_compress_tub
import scipy.io as sio
#def t_svd_test():
M = sio.loadmat('video.mat')
M = M['T']
n1, n2, n3 = M.shape
tol = n1*n2*n3
n0 = min(n1, n2)*n3
###################################################
#                 tSVD Compress
###################################################


RSE = []
I = []
f = 'fft'
for i in range(10):
    I.append(i+1)
    k2 = np.ceil(tol/(i+2))
    k2 = n0-int(k2/n2)
    M2 = L_svd_compress(M, k2-1, flag = f)
    RSE.append(np.linalg.norm(M - M2)/np.linalg.norm(M))
RSE= np.log10(RSE)*20


####################################################
#  tSVD_tubal Compress
####################################################
#M1 = L_svd_compress_tub(M, 5, flag = 'fft')
RSE_tub = []
for i in range(10):
    k2 = np.ceil(n1*n2/((n1+n2+1)*(i+1)))
    k2 = int(k2)
#    print(k2)
    M1 = L_svd_compress_tub(M, k2, flag = 'fft')
    RSE_tub.append(np.linalg.norm(M - M1)/np.linalg.norm(M))
RSE_tub = np.log10(RSE_tub)*20
#plt.plot(RSE_tub, '*-')


####################################################
#    plot figure
####################################################
plt.figure(1)
plt.plot(I, RSE,'*-')
plt.title('basketball')
plt.xlabel('compress ratio')
plt.ylabel('RSE in dB')
plt.plot(I, RSE_tub, '^-')
plt.legend(('tSVD compress','tSVD_tubal Compress'))
#M3 = L_svd_compress(M, 3000, flag = f)
#ratio3 = n1*n2*n3/((n0-3000)*(n1 + n2 + 1))
#plt.figure(2)
#plt.subplot(121)
#plt.imshow(M3[:, :, 1],cmap = 'gray')
#plt.title('t_svd compress')
#plt.subplot(122)
#plt.imshow(M[:, :, 1], cmap = 'gray')
#plt.title('origin')
