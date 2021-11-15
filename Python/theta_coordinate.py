import numpy as np
import numpy.matlib
from scipy.optimize import least_squares

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
    
# finding approximations for Theta_s
import hitpoints # imports the hit point data loaded into python from h5 files

# creating an array of input files
fieldline_file_f = [fldlns_Cbar1_f_10, fldlns_Cbar2_f_10, fldlns_Cbar3_f_10, fldlns_Cbar4_f_10, fldlns_Cbar5_f_10];
fieldline_file_r = [fldlns_Cbar1_r_10, fldlns_Cbar2_r_10, fldlns_Cbar3_r_10, fldlns_Cbar4_r_10, fldlns_Cbar5_r_10];
    
# for finding Theta values simplistically by using Theta = atan(z/(r-r_0))
R_0 = 1.409416688957; # major radius in meters
for i in range(fieldline_file_f.shape[1]):
    Theta_lines_f[:,i] = atan(fieldline_file_f[i].Z_lines[:,2]/(fieldline_file_f[i].R_lines[:,2]-R_0));
    Theta_lines_r[:,i] = atan(fieldline_file_r[i].Z_lines[:,2]/(fieldline_file_r[i].R_lines[:,2]-R_0));
    for t_0 in range(fieldline_file_f(i).PHI_lines.shape[0]):
            if Theta_lines_f[t_0,i] < 0:
                Theta_lines_f[t_0,i] = Theta_lines_f[t_0,i] + 2*pi;
            if Theta_lines_r[t_0,i] < 0:
                Theta_lines_r[t_0,i] = Theta_lines_r[t_0,i] + 2*pi;
# concantenating hitpoints found in the forward and reverse direction into one array as our approximations for Theta
Theta_approx = np.concatenate((Theta_lines_f, Theta_lines_r))

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
    
# using the least squares method to find the closest Theta_s
Theta_s_result = least_squares(chi_squared, Theta_approx, chi_squared_jac, method='lm');
print(Theta_s_result.x);
