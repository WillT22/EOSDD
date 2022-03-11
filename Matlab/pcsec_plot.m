%figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/29/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to show the comparison between the original flux surface and the
% randomized interpolated one
%{
rand_fieldlines = rand_fb_fldln_co_Cbar;
fieldlines = fb_fldlns;
fieldline_number = 11;
%fieldline_number2 = 35;
%
plot3(rand_fieldlines(fieldline_number).r.*cos(rand_fieldlines(fieldline_number).phi),...
    rand_fieldlines(fieldline_number).r.*sin(rand_fieldlines(fieldline_number).phi),...
    rand_fieldlines(fieldline_number).z, '.', 'Color',[1,0.5,0])

%
plot3(fieldlines.R_lines(fieldline_number,:).*cos(fieldlines.PHI_lines(fieldline_number,:)),...
    fieldlines.R_lines(fieldline_number,:).*sin(fieldlines.PHI_lines(fieldline_number,:)),...
    fieldlines.Z_lines(fieldline_number,:))
%

plot3(fieldlines.R_lines(fieldline_number,1:9:end).*cos(fieldlines.PHI_lines(fieldline_number,1:9:end)),...
    fieldlines.R_lines(fieldline_number,1:9:end).*sin(fieldlines.PHI_lines(fieldline_number,1:9:end)),...
    fieldlines.Z_lines(fieldline_number,1:9:end),'.')
%
hold on
plot3(fieldlines(fieldline_number2).r.*cos(fieldlines(fieldline_number2).phi),...
    fieldlines(fieldline_number2).r.*sin(fieldlines(fieldline_number2).phi),...
    fieldlines(fieldline_number2).z,'color','red')
%
hold on
%toroidal_graph(fb_15,2);
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/28/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
fieldline_file_f = fldlns_Xbar_f_10;
fieldline_file_r = fldlns_Xbar_r_20;
vessel_file = pcs_10;

toroidal_graph(vessel_file);
hold on
plot3(fieldline_file_f.X_lines(:,2), fieldline_file_f.Y_lines(:,2), fieldline_file_f.Z_lines(:,2), 'linestyle', 'none', 'marker', '.','color','red');
plot3(fieldline_file_r.X_lines(:,2), fieldline_file_r.Y_lines(:,2), fieldline_file_r.Z_lines(:,2), 'linestyle', 'none', 'marker', '.','color','red');
%}
% to plot groups of hit points together on a surface

fieldline_file_f = [fldlns_Cbar1_f_10, fldlns_Cbar2_f_10, fldlns_Cbar3_f_10,...
    fldlns_Cbar4_f_10, fldlns_Cbar5_f_10];
fieldline_file_r = [fldlns_Cbar1_r_10, fldlns_Cbar2_r_10, fldlns_Cbar3_r_10,...
    fldlns_Cbar4_r_10, fldlns_Cbar5_r_10];
vessel_file = pcs_10;

toroidal_graph(vessel_file);
hold on

plot3(calculated_coordinates.R(7812,2).*cos(PHI_lines_10(7812,2)),...
    calculated_coordinates.R(7812,2).*sin(PHI_lines_10(7812,2)),...
    calculated_coordinates.Z(7812,2),'.','color','red');
xlim([-2.2,2.2]);
ylim([-2.2,2.2]);
zlim([-1.2,1.2]);
daspect([1 1 1]);
grid on;
xlabel('X (meters)');
ylabel('Y (meters)');
zlabel('Z (meters)');

toroidal_graph(vessel_file);
hold on
plot3(calculated_coordinates.R(13744,2).*cos(PHI_lines_10(13744,2)),...
    calculated_coordinates.R(13744,2).*sin(PHI_lines_10(13744,2)),...
    calculated_coordinates.Z(13744,2),'.','color','red');

%{
for i = 1:size(fieldline_file_f,2)
plot3(fieldline_file_f(i).X_lines(:,2), fieldline_file_f(i).Y_lines(:,2), fieldline_file_f(i).Z_lines(:,2), 'linestyle', 'none', 'marker', '.','color','red');
plot3(fieldline_file_r(i).X_lines(:,2), fieldline_file_r(i).Y_lines(:,2), fieldline_file_r(i).Z_lines(:,2), 'linestyle', 'none', 'marker', '.','color','red');
end
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/23/21 & 7/26/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plotting Poincare cross sections with surface cross sections
%{
angle = 90;
p = 180;
t = 90;

fieldlines = fb_fldlns;
%fieldlines = nvactest2;

phi = linspace(0,2*pi,p+1);
angle_rads = angle * pi / 180;
%if ismember(angle_rads, phi);
index = find(phi == angle_rads);

input_angle = angle + 1;
start = index*t+2;
stop = (index+1)*(t);

plot(fieldlines.R_lines(:,input_angle:360:end)',fieldlines.Z_lines(:,input_angle:360:end)',".");
hold on
plot([fb_05.r(start:stop);fb_05.r(start)],[fb_05.z(start:stop);fb_05.z(start)]);
plot([fb_20.r(start:stop);fb_20.r(start)],[fb_20.z(start:stop);fb_20.z(start)]);
plot([fb_35.r(start:stop);fb_35.r(start)],[fb_35.z(start:stop);fb_35.z(start)]);

plot([ntor_testh.r(start:stop);ntor_testh.r(start)],[ntor_testh.z(start:stop);ntor_testh.z(start)]);
plot([ntor_test05h.r(start:stop);ntor_test05h.r(start)],[ntor_test05h.z(start:stop);ntor_test05h.z(start)]);
plot([ntor_test10h.r(start:stop);ntor_test10h.r(start)],[ntor_test10h.z(start:stop);ntor_test10h.z(start)]);
plot([ntor_test15h.r(start:stop);ntor_test15h.r(start)],[ntor_test15h.z(start:stop);ntor_test15h.z(start)]);
plot([ntor_test20h.r(start:stop);ntor_test20h.r(start)],[ntor_test20h.z(start:stop);ntor_test20h.z(start)]);
plot([ntor_test25h.r(start:stop);ntor_test25h.r(start)],[ntor_test25h.z(start:stop);ntor_test25h.z(start)]);
plot([ntor_test30h.r(start:stop);ntor_test30h.r(start)],[ntor_test30h.z(start:stop);ntor_test30h.z(start)]);
plot([ntor_test35h.r(start:stop);ntor_test35h.r(start)],[ntor_test35h.z(start:stop);ntor_test35h.z(start)]);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/22/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(vactest.R_lines(:,1:360:end)',vactest.Z_lines(:,1:360:end)',".");
% plot(nvactest.R_lines(:,1:360:end)',nvactest.Z_lines(:,1:360:end)',".");
%{
plot(nvactest.R_lines(:,1:360:end)',nvactest.Z_lines(:,1:360:end)',".");
hold on
% plot([ntor_testh.r(1:90);ntor_testh.r(1)],[ntor_testh.z(1:90);ntor_testh.z(1)]);
%}

% angle = 30
% plot(vactest2.R_lines(:,30:360:end)',vactest2.Z_lines(:,30:360:end)',".");
% plot(nvactest.R_lines(:,30:360:end)',nvactest.Z_lines(:,30:360:end)',".");
%{
plot(nvactest2.R_lines(:,30:360:end)',nvactest2.Z_lines(:,30:360:end)',".");
hold on
plot([ntor_test2h.r(1457:1547);ntor_test2h.r(1457)],[ntor_test2h.z(1457:1547);ntor_test2h.z(1457)]);
%}

% angle = 60
% plot(vactest.R_lines(:,60:360:end)',vactest.Z_lines(:,60:360:end)',".");
% plot(nvactest.R_lines(:,60:360:end)',nvactest.Z_lines(:,60:360:end)',".");
%{
plot(nvactest.R_lines(:,60:360:end)',nvactest.Z_lines(:,60:360:end)',".");
hold on
plot([ntor_testh.r(2822:2912);ntor_testh.r(2822)],[ntor_testh.z(2822:2912);ntor_testh.z(2822)]);
%}

% angle = 90
% plot(vactest.R_lines(:,90:360:end)',vactest.Z_lines(:,90:360:end)',".");
% plot(nvactest.R_lines(:,90:360:end)',nvactest.Z_lines(:,90:360:end)',".");
%{
plot(nvactest.R_lines(:,90:360:end)',nvactest.Z_lines(:,90:360:end)',".");
hold on
plot([ntor_testh.r(4187:4277);ntor_testh.r(4277)],[ntor_testh.z(4187:4277);ntor_testh.z(4187)]);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/19/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot(vactest.R_lines(:,1:360:end)',vactest.Z_lines(:,1:360:end)',".");
% plot(nvactest.R_lines(:,1:360:end)',nvactest.Z_lines(:,1:360:end)',".");
% plot(vact2.R_lines(:,1:360:end)',vact2.Z_lines(:,1:360:end)',".");
% plot(nvact2.R_lines(:,1:360:end)',nvact2.Z_lines(:,1:360:end)',".");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 6/23/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% flstr = read_fieldlines('../../p/stellopt/ANALYSIS/wteague/VacuumEx/fieldlines_ex/fieldlines_ncsx_c09r00_free.h5');
% plot(flstr.R_lines(:,1:360:end)',flstr.Z_lines(:,1:360:end)',".");
% plot(flstr.R_lines(:,30:360:end)',flstr.Z_lines(:,30:360:end)',".");
% plot(flstr.R_lines(:,60:360:end)',flstr.Z_lines(:,60:360:end)',".");
% plot(flstr.R_lines(:,90:360:end)',flstr.Z_lines(:,90:360:end)',".");

xlim([-2.2,2.2]);
ylim([-2.2,2.2]);
zlim([-1.2,1.2]);
daspect([1 1 1]);
grid on;
xlabel('X (meters)');
ylabel('Y (meters)');
zlabel('Z (meters)');
% set(gca, 'CameraPosition', [0 0 2000]); % top view
% set(gca, 'CameraPosition', [0 0 -2000]); % bottom view
