import numpy as np
import nescin_read as nescin
from scipy.optimize import least_squares

### Import Vessel nescin File ###
M = nescin.M
N = nescin.N
crc2 = nescin.crc2
czs2 = nescin.czs2

### Import Hit Point Data ###
import hitpoints as hp # imports the hit point data loaded into python from h5 files
import hitpoint_data as hpd # imports hitpoint data variables
#+ import theta_approx as ta # imports theta approximations found in the theta_approx file

# importing coordtinates data from hitpoint data set
print('importing hitpoint data')
Phi_h = hpd.Phi[:]
R_h = hpd.R[:]
Z_h = hpd.Z[:]

### Creating Functions to be used in Least Squares Calculation ###
# creating functions for R_s and Z_s
def R_s(Theta_s,M,N,Phi_h):  	
    #initializing arrays for storing outputs of individual elements and summations
    R_s_arr = np.empty(len(M)) 
    #print('R_s')
    for mode in range(len(M)):           
        # Using s=3 and p=1
        R_s_arr[mode] = crc2[mode] * np.cos(M[mode] * Theta_s + 3*N[mode]*Phi_h[coord,file_number])    
#        print('Mode = ', mode)
#        print('M = ',M[mode])
#        print('N = ',N[mode]) 
#        print('crc2 = ',crc2[mode])
#        print('Phi_h = ',Phi_h[coord,file_number]) 
#        print('R_s_arr[mode] = ',R_s_arr[mode])
    R_s_sum = sum(R_s_arr)  
#    print('R_s_sum = ',R_s_sum)
    return R_s_sum
    
def Z_s(Theta_s,M,N,Phi_h):  
    #initializing arrays for storing outputs of individual elements and summations
    Z_s_arr = np.empty(len(M)) 
    #print('Z_s')
    for mode in range(len(M)):            
        # Using s=3 and p=1
        Z_s_arr[mode] = czs2[mode] * np.sin(M[mode] * Theta_s + 3*N[mode]*Phi_h[coord,file_number]);    
#        print('Mode = ', mode)
#        print('M = ',M[mode])
#        print('N = ',N[mode]) 
#        print('czs2 = ',czs2[mode])
#        print('Phi_h = ',Phi_h[coord,file_number]) 
#        print('Z_s_arr[mode] = ',Z_s_arr[mode])
    Z_s_sum = sum(Z_s_arr)
#   print('Z_s_sum = ',Z_s_sum)
    return Z_s_sum

# defining the function that will be used in the least squares method
def chi_squared(Theta_s):
    return np.array([np.subtract(R_s(Theta_s,M,N,Phi_h),R_h[coord,file_number]),np.subtract(Z_s(Theta_s,M,N,Phi_h),Z_h[coord,file_number])])

### Preparing Approximate Theta ###
Theta_approx = np.loadtxt('Theta_approx_10.dat')
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
print(Phi_h.shape)
Theta_s_result = np.empty_like(Phi_h)
for file_number in range(Phi_h.shape[1]):
#for file_number in range(1):
    print('file number', file_number)
    for coord in range(Phi_h.shape[0]):    
    #for coord in range(39997,39998):
#        print('coord = ',coord)
#        print('Phi_h = ',Phi_h[coord,file_number])
#        print('R_h = ',  R_h[coord,file_number])
#        print('Z_h = ',  Z_h[coord,file_number])
#        print('Theta_approx = ',Theta_approx[coord,file_number])
        if coord % 100 == 0:
            print('computing theta', coord)
        Theta_result_temp = least_squares(chi_squared, Theta_approx[coord,file_number], chi_squared_jac, method='lm')
        Theta_s_result[coord,file_number] = Theta_result_temp.x

np.savetxt("Theta_test2.dat",Theta_s_result)
