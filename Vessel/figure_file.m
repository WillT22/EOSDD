figure;
% angle = 0
% plot(vactest.R_lines(:,1:360:end)',vactest.Z_lines(:,1:360:end)',".");
% plot(nvactest.R_lines(:,1:360:end)',nvactest.Z_lines(:,1:360:end)',".");
%{
plot(nvactest.R_lines(:,1:360:end)',nvactest.Z_lines(:,1:360:end)',".");
hold on
plot([ntor_test2.r(1:84);ntor_test2.r(1)],[ntor_test2.z(1:84);ntor_test2.z(1)]);
%}

% angle = 30
% plot(vactest.R_lines(:,30:360:end)',vactest.Z_lines(:,30:360:end)',".");
% plot(nvactest.R_lines(:,30:360:end)',nvactest.Z_lines(:,30:360:end)',".");
%{
plot(nvactest.R_lines(:,30:360:end)',nvactest.Z_lines(:,30:360:end)',".");
hold on
plot([ntor_test2.r(1457:1547);ntor_test2.r(1457)],[ntor_test2.z(1457:1547);ntor_test2.z(1457)]);
%}

% angle = 60
% plot(vactest.R_lines(:,60:360:end)',vactest.Z_lines(:,60:360:end)',".");
% plot(nvactest.R_lines(:,60:360:end)',nvactest.Z_lines(:,60:360:end)',".");
%{
plot(nvactest.R_lines(:,60:360:end)',nvactest.Z_lines(:,60:360:end)',".");
hold on
plot([ntor_test2.r(2822:2912);ntor_test2.r(2822)],[ntor_test2.z(2822:2912);ntor_test2.z(2822)]);
%}

xlim([0.7,2.1]);
ylim([-1,1]);
daspect([1 1 1]);
grid on;
xlabel('R');
ylabel('Z');
