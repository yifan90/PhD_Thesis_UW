% Crop an image f to a circle (or ellipse).
function fp = CropCircle(f)
    sz = size(f);
    xg = linspace(-1,1,sz(1));
    yg = linspace(-1,1,sz(2));
    [x,y] = ndgrid(xg,yg);
    fp = f;
    fp(x.^2+y.^2 > 1) = 0;
end