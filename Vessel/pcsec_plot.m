figure;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/29/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
rand_fieldlines = rand_fb_fldln_co_M;
fieldlines = fb_fldln_co;
fieldline_number = 11;

plot3(rand_fieldlines(fieldline_number).r.*cos(rand_fieldlines(fieldline_number).phi),...
    rand_fieldlines(fieldline_number).r.*sin(rand_fieldlines(fieldline_number).phi),...
    rand_fieldlines(fieldline_number).z, '.', 'Color',[1,0.5,0])

%{
%hold on
plot3(fieldlines(fieldline_number).r.*cos(fieldlines(fieldline_number).phi),...
    fieldlines(fieldline_number).r.*sin(fieldlines(fieldline_number).phi),...
    fieldlines(fieldline_number).z)
%hold on

%toroidal_graph(tv_05h);
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/28/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
fieldline_file = fldlns_fb_25X_HD;
vessel_file = fb_25;

plot3(fieldline_file.X_lines(:,3), fieldline_file.Y_lines(:,3), fieldline_file.Z_lines(:,3), 'linestyle', 'none', 'marker', '.','color','red');
hold on
toroidal_graph(vessel_file);
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 7/23/21 & 7/26/21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

xlim([-2.1,2.1]);
ylim([-2.1,2.1]);
zlim([-1,1]);
daspect([1 1 1]);
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');

