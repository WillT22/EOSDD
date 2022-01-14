import numpy as np
from scipy.optimize import least_squares

### Import Vessel nescin File ###
# read and extract Fourier coeffecients from nescin file
fourier_cell = np.loadtxt('../Vessel/nescin_files/nescin.fb_10',skiprows=172)
M = fourier_cell[:,0]
N = fourier_cell[:,1]
crc2 = fourier_cell[:,2]
czs2 = fourier_cell[:,3]

### Import Hit Point Data ###
import hitpoints as hp # imports the hit point data loaded into python from h5 files
import hitpoint_data as hpd # imports hitpoint data variables
#+ import theta_approx as ta # imports theta approximations found in the theta_approx file

# importing coordtinates data from hitpoint data set and flattening them for use
print('importing hitpoint data')
Phi_h = hpd.Phi[:]
R_h = hpd.R[:]
Z_h = hpd.Z[:]

### Creating Functions to be used in Least Squares Calculation ###
# creating functions for R_s and Z_s
def R_s(Theta_s,M,N,Phi_h):  	
    #initializing arrays for storing outputs of individual elements and summations
    R_s_arr = np.empty(len(M)) 
    for mode in range(len(M)):           
        # Using s=3 and p=1
        R_s_arr[mode] = crc2[mode] * np.cos(M[mode] * Theta_s + 3*N[mode]*Phi_h[coord,file_number]);    
    R_s_fun = sum(R_s_arr)  
    return R_s_fun
    
def Z_s(Theta_s,M,N,Phi_h):  
    #initializing arrays for storing outputs of individual elements and summations
    Z_s_arr = np.empty(len(M)) 
    for mode in range(len(M)):            
        # Using s=3 and p=1
        Z_s_arr[mode] = czs2[mode] * np.sin(M[mode] * Theta_s + 3*N[mode]*Phi_h[coord,file_number]);    
    Z_s_fun = sum(Z_s_arr)
    return Z_s_fun

# defining the function that will be used in the least squares method
def chi_squared(Theta_s):
    return np.array([np.subtract(R_s(Theta_s,M,N,Phi_h),R_h[coord,file_number]),np.subtract(Z_s(Theta_s,M,N,Phi_h),Z_h[coord,file_number])])

### Preparing Approximate Theta ###
# resizing array of approximate thetas into a 1 x n matrix
Theta_approx = np.loadtxt('Theta_approx_file.dat')
# for bypasing saved data file and using the function directly use the following line instead
#Theta_approx = ta.Theta_approx[:]

### Creating Functions to be used in Jacobian Variable ###
# defining the derivatives with repsect to Theta_s of R_s
def R_s_deriv(Theta_s,M,N,Phi_h):
    #initializing arrays for storing outputs of individual elements and summations
    R_s_deriv_arr = np.empty(len(M))
    for mode in range(len(M)):
        # Using s=3 and p=1
        R_s_deriv_arr[mode] = -crc2[mode] * M[mode] * np.sin(M[mode] * Theta_s + 3*N[mode] * Phi_h[coord,file_number]);
    R_s_deriv_fun = sum(R_s_deriv_arr)
    return R_s_deriv_fun

# defining the derivatives with repsect to Theta_s of Z_s
def Z_s_deriv(Theta_s,M,N,Phi_h):
    #initializing arrays for storing outputs of individual elements and summations
    Z_s_deriv_arr = np.empty(len(M))
    for mode in range(len(M)):
        # Using s=3 and p=1
        Z_s_deriv_arr[mode] = czs2[mode] * M[mode] * np.cos(M[mode] * Theta_s + 3*N[mode] * Phi_h[coord,file_number]);
    Z_s_deriv_fun = sum(Z_s_deriv_arr)
    return Z_s_deriv_fun

# defining the Jacobian that will be used in the least squares method
def chi_squared_jac(Theta_s):
    return np.array(([R_s_deriv(Theta_s,M,N,Phi_h)],[Z_s_deriv(Theta_s,M,N,Phi_h)])) 

### Using Least Squares Function ###
# using the least squares method to find the closest Theta_s
print('finding least square')
Theta_s_result = np.empty_like(Phi_h)
for file_number in range(Phi_h.shape[1]):
    print('file number', file_number)
    for coord in range(Phi_h.shape[0]):    
        if coord % 100 == 0:
            print('computing theta', coord)
        Theta_result_temp = least_squares(chi_squared, Theta_approx[coord,file_number], chi_squared_jac, method='lm')
        Theta_s_result[coord,file_number] = Theta_result_temp.x

np.savetxt("Theta_s_t2.dat",Theta_s_result)
