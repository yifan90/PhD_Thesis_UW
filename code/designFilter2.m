function H = designFilter2(filter, n, d)

% Round the filter length up to a power 2 to make the FFT the most
% efficient.
N = pow2(nextpow2(2*n));

if (strcmpi(filter, 'none'))
    H = ones(N, 1);
    return;
end

if (d <= 0)
    H = zeros(N, 1);
    return;
end

d = min(d, 1);

% Design a filter corresponding to taking a derivative in s
%  and then applying a Hilbert transform.
% If sigma is the frequency variable, taking a derivative is equivalent to
%  multiplying by sigma, while the Hilbert transform multiplies all the
%  ``negative'' frequencies by -1. For the discrete Fourier transform, we
%  these are N/2, ..., N-1.

% Create the first half of the filter (the last half will be constructed by
% symmetry)
ramp = (1:N/2) / 8;

% Frequency domain
sigma = pi*ramp;
sigd = sigma / d;

switch lower(filter)
    case 'ram-lak'
        % Nothing to do
        H = ramp;
    case 'shepp-logan'
        % Multiply by a sinc function (sinc(x) = sin(x)/x)
        H = ramp .* sin(sigd/2) ./ (sigd/2);
    case 'cosine'
        % Multiply by a cosine function
        H = ramp .* cos(sigd/2);
    case 'hamming'
        % Multiply by a Hamming window
        H = ramp .* (.54 + .46*cos(sigd));
    case 'hann'
        % Multiply by a Hann window
        H = ramp .* (.5 + .5*cos(sigd));
    case 'lambda'
        % Lambda tomography: perform a Laplacian (in real life
        %  we probably wouldn't do this in the frequency domain.)
        H = ramp .* ramp;
    otherwise
        error('designFilter:unknownFilter', 'Unknown filter type: %s', ...
            filter);
end

% Remove frequencies above the cutoff d.
%H(ramp > d) = 0;
% Extend to negative frequencies by symmetry.
H = [0 H H(end-1:-1:1)]';

end
