function ro = rotateImageVec(im, theta)
%
% Rotate the image im by an angle theta.
%
% im is assumed to be a square matrix, representing an image.
% ro is the rotation of im around its center by the angle theta.
%
% This code uses linear interpolation for the rotation.


% Vectorized version
assert(issquare(im), 'rotateImage:nonsquare', 'Image is not square');

n = size(im, 1);
ro = zeros(n);

z = linspace(-1,1,n);
h = 2/(n-1);

% (x,y) = coordinates of point corresponding to (i,j)
[x,y] = meshgrid(z,z);
% (xr,yr) = rotation of (x,y) by -theta.
% The value of the rotated image at (x,y) will equal the value
%   of the original image at (xr,yr).
% (this is the reason for using -theta instead of theta.)
xr = x * cos(theta) + y * sin(theta);
yr = -x * sin(theta) + y * cos(theta);
% Determine ro(i,j) by linear interpolation
% Convert from (xr,yr) to indices
ir = 1 + (1-yr)/h;
jr = 1 + (xr+1)/h;
% Clamp indices between 1 and n-1 (because we will interpolate
%  between irn and irn+1 and between jrn and jrn+1).
irn = min(n-1, max(1, floor(ir)));
jrn = min(n-1, max(1, floor(jr)));
% Weights
a = ir - irn;
b = jr - jrn;
% Interpolate
sz = size(im);
ro(:) = (1-a).*(1-b).*im(sub2ind(sz,irn,jrn)) + ...
    (1-a).*b.*im(sub2ind(sz,irn,jrn+1)) + ...
    a.*(1-b).*im(sub2ind(sz,irn+1,jrn)) + ...
    a.*b.*im(sub2ind(sz,irn+1,jrn+1));

ro((x.^2 + y.^2) > 1) = 0;
