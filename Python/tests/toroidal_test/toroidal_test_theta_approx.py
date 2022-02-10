import numpy as np
import nescin_read as nescin

import sys
np.set_printoptions(threshold=sys.maxsize)

# finding approximations for Theta_s
import hitpoints as hp # imports the hit point data loaded into python from h5 files

# for finding r_0 value in nescin data file
for mode in range(len(nescin.M)):
    if nescin.M[mode] == 0 and nescin.N[mode] == 0:
        R_0 = nescin.crc2[mode] # major radius in meters
print(R_0)
f_R_lines = np.loadtxt('./tests/toroidal_test/toroidal_test_R.dat')
f_Z_lines = np.loadtxt('./tests/toroidal_test/toroidal_test_Z.dat')
# for finding Theta values simplistically by using Theta = atan(z/(r-r_0))
Theta_lines_f = np.empty([len(f_R_lines)])
for i in range(len(f_R_lines)):
	Theta_lines_f[i] = np.arctan2(f_Z_lines[i],(f_R_lines[i]-R_0))
	if Theta_lines_f[i] < 0:
		Theta_lines_f[i] = Theta_lines_f[i] + 2*np.pi
# concantenating hitpoints found in the forward and reverse direction into one array as our approximations for Theta
Theta_approx = Theta_lines_f

# writing Theta approximation points to a file
np.savetxt("toroidal_test_theta_approx.dat",Theta_approx)
