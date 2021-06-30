function [fvstruct] = toroidal_mesh(r, z, theta, phi)
%TOROIDAL_MESH(r, z, theta, phi)
% Generates a triangular surface (patch) structure based on grids of
% r and z coordinates at defined values of theta and phi angles.
%
% Parameters:
%     r, z: 2D arrays
%         r and z coordinates of each mesh point. Theta varies across the
%         columns; phi varies down the rows.
%     theta, phi: 1D arrays
%         Theta and phi coordinates corresponding to the elements of r
%         and z. Theta must have the same number of elements as the 
%         number of columns in r and z; phi must have the same number of 
%         elements as the number of rows of r and z.
%
% Returns:
%     fvstruct: structure
%         Structure of face and vertex information suitable for input
%         to the patch() function.
%
%


    [nTheta, nPhi] = size(r);
    nPoints = nTheta*nPhi;
    if nTheta ~= size(z,1) || nPhi ~= size(z,2)
        error('Dimensions of r and z must agree');    
    elseif length(theta(:)) ~= nPhi
        error('Number of rows of r and z must agree with length of phi');
    elseif length(phi(:)) ~= nTheta
        error(['Number of columns of r and z must agree with length of theta']);
    end
    
    indArray = reshape(1:nPoints, nTheta, nPhi);
    upperLefts  = indArray(1:end-1, 1:end-1);       % upper left vertices of the grid
    upperRights = indArray(1:end-1, 2:end  );       % upper right vertices of the grid
    lowerLefts  = indArray(2:end,   1:end-1);       % lower left vertices of the grid
    lowerRights = indArray(2:end,   2:end  );       % lower right vertices of the grid
    
    faces = [upperLefts(:)  upperRights(:) lowerLefts(:); ...   % makes the upper triangles
             upperRights(:) lowerRights(:) lowerLefts(:);];     % makes the lower triangles
    
    [~, Phi] = meshgrid(theta, phi);
    x = r.*cos(Phi);
    y = r.*sin(Phi);
    
    vertices = [x(:) y(:) z(:)];
    
    fvstruct.faces = faces;
    fvstruct.vertices = vertices;
    
