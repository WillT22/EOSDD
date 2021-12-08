import numpy as np
from scipy.optimize import least_squares
import hitpoints as hp # imports the hit point data loaded into python from h5 files
import phi_lines_import as phi_lines # imports PHI_lines as a usable variable
#import theta_approx as ta # imports theta approximations found in the theta_approx file

# read and extract Fourier coeffecients from nescin file
fourier_cell = np.loadtxt('../Vessel/nescin_files/nescin.fb_10',skiprows=172)
M = fourier_cell[:,0]
N = fourier_cell[:,1]
crc2 = fourier_cell[:,2]
czs2 = fourier_cell[:,3]
#importing Phi coordtinate data from hitpoint data set
Phi_h = phi_lines.Phi[:];
Phi_h = Phi_h.flatten();

# creating functions for R_s and Z_s
def R_s(Theta_s,M,N,Phi_h):  
    #initializing arrays for storing outputs of individual elements and summations
    R_s_arr = np.empty([len(Phi_h),len(M)]); 
    R_s_functions = np.empty(len(Phi_h));
    for coord in range(len(Phi_h)):
        for mode in range(len(M)):            
            # Using s=3 and p=1
            R_s_arr[coord,mode] = crc2[mode] * np.cos(M[mode]*Theta_s[coord] + 3*N[mode]*Phi_h[coord]);    
        R_s_functions[coord] = sum(R_s_arr[coord]);  
    return
    
def Z_s(Theta_s,M,N,Phi_h):  
    #initializing arrays for storing outputs of individual elements and summations
    Z_s_arr = np.empty([len(Phi_h),len(M)]); 
    Z_s_functions = np.empty(len(Phi_h));
    for coord in range(len(Phi_h)):
        for mode in range(len(M)):            
            # Using s=3 and p=1
            Z_s_arr[coord,mode] = czs2[mode] * np.sin(M[mode]*Theta_s[coord] + 3*N[mode]*Phi_h[coord]);    
        Z_s_functions[coord] = sum(Z_s_arr[coord]);
    return
    
# defining the function that will be used in the least squares method
def chi_squared(Theta_s):
    return np.array([R_s(Theta_s,M,N,Phi_h)-R_h],[Z_s(Theta_s,M,N,Phi_h)-Z_h])

# defining the derivatives with repsect to Theta_s of R_s
def R_s_deriv(Theta_s,M,N,Phi_h):
    #initializing arrays for storing outputs of individual elements and summations
    R_s_deriv_arr = np.empty([len(Phi_h),len(M)]);
    R_s_deriv_functions = np.empty(len(Phi_h));
    for coord in range(len(Phi_h)):
        for mode in range(len(M)):
            # Using s=3 and p=1
            R_s_deriv_arr[coord,mode] = -crc2[coord] * M[mode] * np.sin(M[mode]*Theta_s[coord] + 3*N[mode]*Phi_h[coord]);
        R_s_deriv_functions[coord] = sum(R_s_deriv_arr[coord]);
    return

# defining the derivatives with repsect to Theta_s of Z_s
def Z_s_deriv(Theta_s,M,N,Phi_h):
    #initializing arrays for storing outputs of individual elements and summations
    Z_s_deriv_arr = np.empty([len(Phi_h),len(M)]);
    Z_s_deriv_functions = np.empty(len(Phi_h));
    for coord in range(len(Phi_h)):
        for mode in range(len(M)):
            # Using s=3 and p=1
            Z_s_deriv_arr[coord,mode] = czs2[coord] * M[mode] * np.cos(M[mode]*Theta_s[coord] + 3*N[mode]*Phi_h[coord]);
        Z_s_deriv_functions[coord] = sum(Z_s_deriv_arr[coord]);
    return

# defining the Jacobian that will be used in the least squares method
def chi_squared_jac(Theta_s):
    return np.array([R_s_deriv(Theta_s,M,N,Phi_h)],[Z_s_deriv(Theta_s,M,N,Phi_h)])

# resizing array of approximate thetas into a 1 x n matrix
Theta_approx = np.loadtxt('Theta_approx_file.dat')
# for bypasing saved data file and using the function directly use the following line instead
#Theta_approx = ta.Theta_approx[:];
# flattens Theta_approx into a 1D matrix for use in least_squares
Theta0 = Theta_approx.flatten();
    
# using the least squares method to find the closest Theta_s
Theta_s_result = least_squares(chi_squared, Theta0, chi_squared_jac, method='lm');
print(Theta_s_result.x);
