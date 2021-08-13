
vessel_file = [fb_05, fb_10, fb_15, fb_20, fb_25, fb_30, fb_35];
fieldline_file = [fldlns_fb_05X_HD, fldlns_fb_10X_HD, fldlns_fb_15X_HD, fldlns_fb_20X_HD, fldlns_fb_25C, fldlns_fb_30X_HD, fldlns_fb_35X_HD];

for i = 1:7
    fig = figure;
        toroidal_graph(vessel_file(i));
        hold on
        plot3(fieldline_file(i).X_lines(:,3), fieldline_file(i).Y_lines(:,3), fieldline_file(i).Z_lines(:,3), 'linestyle', 'none', 'marker', '.','color','red');
            xlim([-2.2,2.2]);
            ylim([-2.2,2.2]);
            zlim([-1.2,1.2]);
            daspect([1 1 1]);
            xlabel('X');
            ylabel('Y');
            zlabel('Z');
            % set(gca, 'CameraPosition', [0 0 2000]); % top view
            % set(gca, 'CameraPosition', [0 0 -2000]); % bottom view
        frame = getframe(fig);
        im{i} = frame2im(frame);
        
end

%{ 
% toroidal vessels increasing in size
fig = figure;
    toroidal_graph(fb_05);
        xlim([-2.2,2.2]);
        ylim([-2.2,2.2]);
        zlim([-1.2,1.2]);
        daspect([1 1 1]);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    frame = getframe(fig);
    im{1} = frame2im(frame);
fig = figure;
    toroidal_graph(fb_10);
        xlim([-2.2,2.2]);
        ylim([-2.2,2.2]);
        zlim([-1.2,1.2]);
        daspect([1 1 1]);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    frame = getframe(fig);
    im{2} = frame2im(frame);
fig = figure;
    toroidal_graph(fb_15);
        xlim([-2.2,2.2]);
        ylim([-2.2,2.2]);
        zlim([-1.2,1.2]);
        daspect([1 1 1]);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    frame = getframe(fig);
    im{3} = frame2im(frame);
fig = figure;
    toroidal_graph(fb_20);
        xlim([-2.2,2.2]);
        ylim([-2.2,2.2]);
        zlim([-1.2,1.2]);
        daspect([1 1 1]);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    frame = getframe(fig);
    im{4} = frame2im(frame);
fig = figure;
    toroidal_graph(fb_25);
        xlim([-2.2,2.2]);
        ylim([-2.2,2.2]);
        zlim([-1.2,1.2]);
        daspect([1 1 1]);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    frame = getframe(fig);
    im{5} = frame2im(frame);
fig = figure;
    toroidal_graph(fb_30);
        xlim([-2.2,2.2]);
        ylim([-2.2,2.2]);
        zlim([-1.2,1.2]);
        daspect([1 1 1]);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    frame = getframe(fig);
    im{6} = frame2im(frame);
fig = figure;
    toroidal_graph(fb_35);
        xlim([-2.2,2.2]);
        ylim([-2.2,2.2]);
        zlim([-1.2,1.2]);
        daspect([1 1 1]);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    frame = getframe(fig);
    im{7} = frame2im(frame);
%}    
clear fig;
clear frame;

figure;
for idx = 1:7
    subplot(3,3,idx)
    imshow(im{idx});
end

filename = 'SULI21/gif/C_bottom.gif'; % Specify the output file name
for idx = 1:7
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end