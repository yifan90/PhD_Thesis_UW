function square = issquare(M)

sizes = size(M);
square = (length(sizes) == 2) && (sizes(1) == sizes(2));
