function BP = radonBP2(RT, thetas, n)
%
% Backprojection for Radon transforms
%
% Inputs
%      RT: Radon transform of image
%  thetas: vector of angles in RT
%           (length(thetas) must equal the number of columns of RT)
%       n: size of reconstructed image (image will be n by n)
%
% Outputs
%      BP: backprojected image (n by n matrix)
%

% Check that the input dimensions make sense
ntheta = length(thetas);
assert(ntheta == size(RT,2), 'radonBP:dimensionMismatch', ...
    'The number of angles does not match the number of columns in the input image');

% Set up variables
ns = size(RT,1);
ds = 2. / (ns-1);

% Set up grid and reconstructed image
z = linspace(-1, 1, n);
[x,y] = meshgrid(z,z);
y = flipud(y);
BP = zeros(n);

% Assume the theta data is equally spaced
dtheta = thetas(2) - thetas(1);

for i = 1:ntheta
	s = x*cos(thetas(i)) + y*sin(thetas(i));
	j = 1 + ((s + 1) / ds);
    jn = max(1, min(ns-1, floor(j)));
    a = j - jn;
    RTc = RT(:,i);
    BP = BP + (a .* RTc(jn+1) + (1-a) .* RTc(jn)) * dtheta;
end

BP = BP * 2; 

