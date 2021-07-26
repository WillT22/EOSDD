
fig = figure;
    toroidal_graph(ntor_test05h);
    frame = getframe(fig);
    im{1} = frame2im(frame);
fig = figure;
    toroidal_graph(ntor_test10h);
    frame = getframe(fig);
    im{2} = frame2im(frame);
fig = figure;
    toroidal_graph(ntor_test15h);
    frame = getframe(fig);
    im{3} = frame2im(frame);
fig = figure;
    toroidal_graph(ntor_test20h);
    frame = getframe(fig);
    im{4} = frame2im(frame);
fig = figure;
    toroidal_graph(ntor_test25h);
    frame = getframe(fig);
    im{5} = frame2im(frame);
fig = figure;
    toroidal_graph(ntor_testh);
    frame = getframe(fig);
    im{6} = frame2im(frame);
fig = figure;
    toroidal_graph(ntor_test30h);
    frame = getframe(fig);
    im{7} = frame2im(frame);
fig = figure;
    toroidal_graph(ntor_test35h);
    frame = getframe(fig);
    im{8} = frame2im(frame);
    
clear fig;
clear frame;

figure;
for idx = 1:8
    subplot(3,3,idx)
    imshow(im{idx});
end

filename = 'vessel_separation_updated2.gif'; % Specify the output file name
for idx = 1:8
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end