figure;
% angle = 0
% plot(vactest.R_lines(:,1:360:end)',vactest.Z_lines(:,1:360:end)',".");
% plot(nvactest.R_lines(:,1:360:end)',nvactest.Z_lines(:,1:360:end)',".");

% angle = 30
% plot(vactest.R_lines(:,30:360:end)',vactest.Z_lines(:,30:360:end)',".");
% plot(nvactest.R_lines(:,30:360:end)',nvactest.Z_lines(:,30:360:end)',".");

% angle = 60
% plot(vactest.R_lines(:,60:360:end)',vactest.Z_lines(:,60:360:end)',".");
% plot(nvactest.R_lines(:,60:360:end)',nvactest.Z_lines(:,60:360:end)',".");

xlim([0.85,1.8]);
ylim([-0.65,0.65]);
daspect([1 1 1]);
grid on;
xlabel('R');
ylabel('Z');
