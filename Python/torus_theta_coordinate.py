import numpy as np
import nescin_read as nescin
from scipy.optimize import least_squares

### Input Files ###
# importing coordtinates data from hitpoint data set
print('importing hitpoint data')
Phi_h = np.loadtxt('./tests/torus_test/torus_test_Phi.dat')
R_h = np.loadtxt('./tests/torus_test/torus_test_R.dat')
Z_h = np.loadtxt('./tests/torus_test/torus_test_Z.dat')

# Preparing Approximate Theta
Theta_approx = np.loadtxt('./tests/torus_test/torus_test_Theta_p.dat')
# for bypasing saved data file and using the function directly use the following line instead
#Theta_approx = ta.Theta_approx[:]

# file where theta data will be printed
data_file = "torus_theta_test.dat"

### Creating Functions to be used in Least Squares Calculation ###
R = 1.5
r = 0.5
# creating functions for R_s and Z_s
def R_s(Theta_s):  	
    R_s_fun = R+r*np.cos(Theta_s)
    return R_s_fun
    
def Z_s(Theta_s):  
    Z_s_fun = r*np.sin(Theta_s)
    return Z_s_fun

# defining the function that will be used in the least squares method
def chi_squared(Theta_s):
    return np.array([np.subtract(R_s(Theta_s),R_h[coord,file_number]),np.subtract(Z_s(Theta_s),Z_h[coord,file_number])])

### Creating Functions to be used in Jacobian Variable ###
# defining the derivatives with repsect to Theta_s of R_s
def R_s_deriv(Theta_s):
    R_s_deriv_fun = -r*np.sin(Theta_s)
    return R_s_deriv_fun

# defining the derivatives with repsect to Theta_s of Z_s
def Z_s_deriv(Theta_s):
    Z_s_deriv_fun = r*np.cos(Theta_s)
    return Z_s_deriv_fun

# defining the Jacobian that will be used in the least squares method
def chi_squared_jac(Theta_s):
    return np.array(([R_s_deriv(Theta_s)],[Z_s_deriv(Theta_s)])) 

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

np.savetxt(data_file,Theta_s_result)
