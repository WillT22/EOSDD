import numpy as np
import hitpoints as hp # imports the hit point data loaded into python from h5 files
import sys
np.set_printoptions(threshold=sys.maxsize)

# creating an array of input files
fieldline_file_f = [hp.fldlns_Cbar1_f_10, hp.fldlns_Cbar2_f_10, hp.fldlns_Cbar3_f_10, hp.fldlns_Cbar4_f_10, hp.fldlns_Cbar5_f_10]
fieldline_file_r = [hp.fldlns_Cbar1_r_10, hp.fldlns_Cbar2_r_10, hp.fldlns_Cbar3_r_10, hp.fldlns_Cbar4_r_10, hp.fldlns_Cbar5_r_10]
# importing Phi coordtinate data from hitpoint data set
Phi_lines_f = np.empty([len(fieldline_file_f[0].get('PHI_lines')[0]),len(fieldline_file_f)])
Phi_lines_r = np.empty([len(fieldline_file_f[0].get('PHI_lines')[0]),len(fieldline_file_f)])
for f in range(len(fieldline_file_f)):
	Phi_lines_f[:,f] = fieldline_file_f[f].get('PHI_lines')[1,:]
	Phi_lines_r[:,f] = fieldline_file_r[f].get('PHI_lines')[1,:]
	for i in range(len(fieldline_file_f[f].get('PHI_lines')[1])):
		if Phi_lines_f[i,f] < 0:
			Phi_lines_f[i,f] = Phi_lines_f[i,f] + 2*np.pi
		if Phi_lines_r[i,f] < 0:
			Phi_lines_r[i,f] = Phi_lines_r[i,f] + 2*np.pi
# concantenating Phi for hitpoints found in the forward and reverse direction into one array
Phi = np.concatenate((Phi_lines_f, Phi_lines_r))

# importing R cordinate for hitpoints 
R_lines_f = np.empty([len(fieldline_file_f[0].get('R_lines')[0]),len(fieldline_file_f)])
R_lines_r = np.empty([len(fieldline_file_f[0].get('R_lines')[0]),len(fieldline_file_f)])
for f in range(len(fieldline_file_f)):
        R_lines_f[:,f] = fieldline_file_f[f].get('R_lines')[1,:]
        R_lines_r[:,f] = fieldline_file_r[f].get('R_lines')[1,:]
# concantenating R value for hitpoints found in the forward and reverse direction into one array
R = np.concatenate((R_lines_f, R_lines_r))

# importing R cordinate for hitpoints 
Z_lines_f = np.empty([len(fieldline_file_f[0].get('Z_lines')[0]),len(fieldline_file_f)])
Z_lines_r = np.empty([len(fieldline_file_f[0].get('Z_lines')[0]),len(fieldline_file_f)])
for f in range(len(fieldline_file_f)):
        Z_lines_f[:,f] = fieldline_file_f[f].get('Z_lines')[1,:]
        Z_lines_r[:,f] = fieldline_file_r[f].get('Z_lines')[1,:]
# concantenating R value for hitpoints found in the forward and reverse direction into one array
Z = np.concatenate((R_lines_f, R_lines_r))

np.savetxt("Phi_file.dat",Phi)
np.savetxt("R_file.dat",R)
np.savetxt("Z_file.dat",Z)

