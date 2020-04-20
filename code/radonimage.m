    im1=rgb2gray(im2double(imread('bigc.png')));
    im1 = ones(256)-(im1==1);
    im2=rgb2gray(im2double(imread('smallc.png')));
    im2 = ones(256)-im2;
    im3=rgb2gray(im2double(imread('ao.png')));
    im3 = ones(256)-im3;
    
    im=im3;
    
    N=size(im,1);
    nthetas = 180;
    ns=256;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RT = myRadon(im, thetas);
    
    sidx = 1:sdivider:N;
    RT = RT(sidx,:);
    RT = [RT RT(256:-1:1,:)];
    RT = RT(256:-1:1,:);
%    M= max(max(RT));
%    RT(:,180)=M*ones(256,1);
    
    
    imshow(RT/max(max(RT(:))));