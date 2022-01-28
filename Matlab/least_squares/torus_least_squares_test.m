R = 1.5;
r = 0.5;
torus_test = torus_vd(R,r,180,90);
%toroidal_graph(torus_test)

pcs_10 = toroidal_mesh('../../p/stellopt/ANALYSIS/wteague/flux_surface/nvac_fldlns/fb_bnorm/nescin.fb_10',180,90);

least_squares_test(torus_test);




