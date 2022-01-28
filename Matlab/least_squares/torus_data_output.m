fid = fopen('EOSDD/Python/tests/torus_test/torus_test_R.dat','w');
fprintf(fid, '%.20f    %.20f \n',random_torus_hitpoints.r');
fclose(fid);

fid = fopen('EOSDD/Python/tests/torus_test/torus_test_Phi.dat','w');
fprintf(fid, '%.20f    %.20f \n',random_torus_hitpoints.phi');
fclose(fid);

fid = fopen('EOSDD/Python/tests/torus_test/torus_test_Z.dat','w');
fprintf(fid, '%.20f    %.20f \n',random_torus_hitpoints.z');
fclose(fid);

fid = fopen('EOSDD/Python/tests/torus_test/torus_test_Theta_p.dat','w');
fprintf(fid, '%.20f    %.20f \n',random_torus_hitpoints.perturbed_theta');
fclose(fid);

fid = fopen('EOSDD/Python/tests/torus_test/torus_test_Theta_e.dat','w');
fprintf(fid, '%.20f    %.20f \n',random_torus_hitpoints.exact_theta');
fclose(fid);