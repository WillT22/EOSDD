import numpy as np

### Import Vessel nescin File ###
# read and extract Fourier coeffecients from nescin file
fourier_cell = np.loadtxt('../Matlab/nescin_files/nescin.fb_10',skiprows=172)
M = fourier_cell[:,0]
N = fourier_cell[:,1]
crc2 = fourier_cell[:,2]
czs2 = fourier_cell[:,3]
