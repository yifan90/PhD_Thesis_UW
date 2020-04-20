function RT = myRadon(im, thetas)
%
% Compute the Radon transform of the image im.
%   im is mapped to the square [-1,1] x [-1,1]
%
% Inputs
%
%      im: square matrix representing the image
%  thetas: angles at which to compute the Radon transform of im
%
% Output
%
%      RT: Radon transform of im
%            RT(i,j) = Radon transform of f
%                  i is the s-variable (same scale as x,y variables)
%                  j is the theta-variable.


assert(issquare(im), 'myRadon:notsquare', 'Image is not a square matrix.');

n = size(im,1);
ntheta = length(thetas);
RT = zeros(n,ntheta);
for j = 1:ntheta
	% Rotate image by -theta(j) to align x-axis with theta
    % Then find the Radon transform by summing the columns.
	RT(:,j) = (2 / n) * sum(rotateImageVec(im, -thetas(j)), 1);
end


% Zero pad so that the range of s is [-\sqrt(2),\sqrt(2)]
%zp = ceil((sqrt(2) - 1) * n/2);
%RT = [zeros(zp,ntheta); RT; zeros(zp,ntheta)];

