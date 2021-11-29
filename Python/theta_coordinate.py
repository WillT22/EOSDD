import numpy as np
from scipy.optimize import least_squares
import theta_approx as ta # imports theta approximations found in the theta_approx file

# creating functions for R_s and Z_s
def R_s(Theta_s,M,N,Phi_h):  
    #initializing arrays for storing outputs of individual elements and summations
    R_s_arr = np.empty([len(Phi_h),len(M)]); 
    R_s_functions = np.empty(len(Phi_h));
    for coord in range(len(Phi_h)):
        for mode in range(len(M)):            
            # Using s=3 and p=1
            R_s_arr[coord,mode] = crc2[coord] * np.cos(M[mode]*Theta_s[coord] + 3*N[mode]*Phi_h[coord]);    
        R_s_functions[coord] = sum(R_s_arr[coord]);  
    return
    
def Z_s(Theta_s,M,N,Phi_h):  
  #initializing arrays for storing outputs of individual elements and summations
    Z_s_arr = np.empty([len(Phi_h),len(M)]); 
    Z_s_functions = np.empty(len(Phi_h));
    for coord in range(len(Phi_h)):
        for mode in range(len(M)):            
            # Using s=3 and p=1
            Z_s_arr[coord,mode] = czs2[coord] * np.sin(M[mode]*Theta_s[coord] + 3*N[mode]*Phi_h[coord]);    
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
Theta_approx = ta.Theta_approx[:];
print(Theta_approx.shape);
#total_elements = len(Theta_approx[0]) * len(Theta_approx[1]);
#print(total_elements) 
Theta0 = Theta_approx.flatten();
print(Theta0.shape);
print(Theta0.ndim);
    
# using the least squares method to find the closest Theta_s
Theta_s_result = least_squares(chi_squared, Theta0, chi_squared_jac, method='lm');
print(Theta_s_result.x);
