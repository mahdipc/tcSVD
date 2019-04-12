# -*- coding: utf-8 -*-
"""
Created on Thu Apr 26 16:45:55 2018

@author: lsj
"""
import matplotlib.pyplot as plt
import numpy as np
import sys
sys.path.append("..")
from L_svd import L_svd
from L_prod import L_prod
# from L_svd_compress import L_svd_compress
import scipy.io as sio
def t_svd_test():
    M = sio.loadmat('video.mat')
    M = M['T']
    a1,b1,c1  = L_svd(M, flag = 'fft')
    M_svd = L_prod(L_prod(a1,b1, flag = 'fft'), c1, flag = 'fft').real
    err = M-M_svd
    print('The RSE =',np.linalg.norm(err))
    print('Transformed Tensor is equal to the origin:', np.allclose(M, M_svd))
    plt.subplot(121)
    plt.imshow(M_svd[:, :, 1],cmap = 'gray')
    plt.title('t_svd result')
    plt.subplot(122)
    plt.imshow(M[:, :, 1], cmap = 'gray')
    plt.title('origin')
if __name__=='__main__':
    t_svd_test()
