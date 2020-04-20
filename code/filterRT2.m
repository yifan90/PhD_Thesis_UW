function [RTF,H] = filterRT2(RT, filter, d)
%
% Filter Radon transform
%
% Most of this code (and the following function, designFilter)
%  comes from code written by Francois Monard. Thanks, Francois!
%
% Inputs
%      RT: Radon transform of image
%  filter: type of filter (string). Possibilities:
%           'none', 'ram-lak', 'shepp-logan', 'cosine', 'hann', 'hamming'
%       d: high-frequency cutoff (0 < d <= 1)
%           1 means no cut off, while 0 cuts off all frequencies
%           0.5 would cut off half the frequencies (the highest ones).
%
% Outputs
%     RTF: filtered image (same dimensions as RT)
%       H: filter (in Fourier domain)
%

ns = size(RT,1);
ntheta = size(RT,2);

% Setup the filter
H = designFilter2(filter, ns, d);

% Pad Radon transform to size of filter (a power of two).
l = length(H);
RTF = [RT ; zeros(l - ns, ntheta)];

% Transform to Fourier domain
RTF = fft(RTF);

% Apply filter (multiplication in Fourier domain)
for i = 1:ntheta
   RTF(:,i) = RTF(:,i) .* H;
end

% Return to spatial domain
RTF = real(ifft(RTF));

% Remove padding
RTF(ns+1:end, :) = [];

end

