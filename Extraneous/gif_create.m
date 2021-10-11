
filename = 'Figures/Xbar_bottom.gif'; % Specify the output file name

vessel_file = [fb_05, fb_10, fb_15, fb_20, fb_25, fb_30, fb_35];

fieldline_file = [fldlns_Xbar_f_05, fldlns_Xbar_f_10, fldlns_Xbar_f_15, fldlns_Xbar_f_20, fldlns_Xbar_f_25];
%, fldlns_fb_30C, fldlns_fb_35C];
fieldline_file_rev = [fldlns_Xbar_r_05, fldlns_Xbar_r_10, fldlns_Xbar_r_15, fldlns_Xbar_r_20, fldlns_Xbar_r_25];
%, fldlns_fb_30C_rev, fldlns_fb_35C_rev];

for i = 1:size(fieldline_file,2)
    fig = figure;
        toroidal_graph(vessel_file(i));
        hold on
        plot3(fieldline_file(i).X_lines(:,2), fieldline_file(i).Y_lines(:,2), fieldline_file(i).Z_lines(:,2), 'linestyle', 'none', 'marker', '.','color','red');
        plot3(fieldline_file_rev(i).X_lines(:,2), fieldline_file_rev(i).Y_lines(:,2), fieldline_file_rev(i).Z_lines(:,2), 'linestyle', 'none', 'marker', '.','color','red');    
            xlim([-2.2,2.2]);
            ylim([-2.2,2.2]);
            zlim([-1.2,1.2]);
            daspect([1 1 1]);
            xlabel('X');
            ylabel('Y');
            zlabel('Z');
            % set(gca, 'CameraPosition', [0 0 2000]); % top view
             set(gca, 'CameraPosition', [0 0 -2000]); % bottom view
        frame = getframe(fig);
        im{i} = frame2im(frame);
        
end

%{
fieldline_number = 11;
rand_fieldlines = [rand_fb_fldln_co_C(fieldline_number), rand_fb_fldln_co_M(fieldline_number), rand_fb_fldln_co_Xbar(fieldline_number), rand_fb_fldln_co_Cbar(fieldline_number), rand_fb_fldln_co_T(fieldline_number)];

for i = 1:5
    fig = figure;
    plot3(rand_fieldlines(i).r.*cos(rand_fieldlines(i).phi),...
        rand_fieldlines(i).r.*sin(rand_fieldlines(i).phi),...
        rand_fieldlines(i).z, '.', 'Color',[1,0.5,0])
            xlim([-2.2,2.2]);
            ylim([-2.2,2.2]);
            zlim([-1.2,1.2]);
            daspect([1 1 1]);
            xlabel('X');
            ylabel('Y');
            zlabel('Z');
        frame = getframe(fig);
        im{i} = frame2im(frame);
        
end
%}
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
for idx = 1:size(fieldline_file,2)
    subplot(3,3,idx)
    imshow(im{idx});
end

for idx = 1:size(fieldline_file,2)
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end