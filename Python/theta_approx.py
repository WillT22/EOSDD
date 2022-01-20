import numpy as np
import nescin_read as nescin

import sys
np.set_printoptions(threshold=sys.maxsize)

# finding approximations for Theta_s
import hitpoints as hp # imports the hit point data loaded into python from h5 files

# creating an array of input files
fieldline_file_f = [hp.fldlns_Cbar1_f_10, hp.fldlns_Cbar2_f_10, hp.fldlns_Cbar3_f_10, hp.fldlns_Cbar4_f_10, hp.fldlns_Cbar5_f_10]
fieldline_file_r = [hp.fldlns_Cbar1_r_10, hp.fldlns_Cbar2_r_10, hp.fldlns_Cbar3_r_10, hp.fldlns_Cbar4_r_10, hp.fldlns_Cbar5_r_10]

# for finding r_0 value in nescin data file
for mode in range(len(nescin.M)):
    if nescin.M[mode] == 0 and nescin.N[mode] == 0:
        R_0 = nescin.crc2[mode] # major radius in meters
print(R_0)
# for finding Theta values simplistically by using Theta = atan(z/(r-r_0))
Theta_lines_f = np.empty([len(fieldline_file_f[0].get('R_lines')[0]),len(fieldline_file_f)])
Theta_lines_r = np.empty([len(fieldline_file_f[0].get('R_lines')[0]),len(fieldline_file_f)])
for f in range(len(fieldline_file_f)):
	f_R_lines = fieldline_file_f[f].get('R_lines')
	f_Z_lines = fieldline_file_f[f].get('Z_lines')
	r_R_lines = fieldline_file_r[f].get('R_lines')
	r_Z_lines = fieldline_file_r[f].get('Z_lines')
	for i in range(len(f_R_lines[1])):
		Theta_lines_f[i,f] = np.arctan2(f_Z_lines[1,i],(f_R_lines[1,i]-R_0))
		Theta_lines_r[i,f] = np.arctan2(r_Z_lines[1,i],(r_R_lines[1,i]-R_0))
		if Theta_lines_f[i,f] < 0:
			Theta_lines_f[i,f] = Theta_lines_f[i,f] + 2*np.pi
		if Theta_lines_r[i,f] < 0:
			Theta_lines_r[i,f] = Theta_lines_r[i,f] + 2*np.pi
	print('File ' + str(f+1) + ' of ' + str(len(fieldline_file_f)) + ' computed')
# concantenating hitpoints found in the forward and reverse direction into one array as our approximations for Theta
Theta_approx = np.concatenate((Theta_lines_f, Theta_lines_r))

# writing Theta approximation points to a file
np.savetxt("Theta_approx_file_test.dat",Theta_approx)
