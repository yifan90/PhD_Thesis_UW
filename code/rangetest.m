%    im=CropCircle(rgb2gray(im2double(imread('Lenna.png'))));

%    ´óÈ¦Ì×Ð¡
    t=-3:6/512:3;
    t=t(1:512);
    t=t';
    t=ff(t);

    N=512;
    nthetas = 180;
    ns=512;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    RT=zeros(512,180);
    for i = 1:180
        RT(:,i)=t;
    end
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RTF = filterRT2(RT, filter, 1);
    BP = radonBP2(RTF, thetas, N);
    BP = CropCircle(BP);
    
    imshow(BP/max(BP(:)));