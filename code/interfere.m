%    im=CropCircle(rgb2gray(im2double(imread('Lenna.png'))));

%    ´óÈ¦Ì×Ð¡È¦
    im1=zeros(512,512);
    im2=im1; im3 = im2;
    for i=1:512
        for j=1:512
            if (i-220)^2+(j-220)^2<=28625
                im1(i,j)=1;
            end
        end
    end
    for i=1:512
        for j=1:512
            if (i-170)^2+(j-200)^2<=40^2
                im2(i,j)=1;
            end
        end
    end
    
    for i=1:512
        for j=1:512
            if (i-270)^2+(j-280)^2<=20^2
                im3(i,j)=1;
            end
        end
    end
    
    N=size(im1,1);
    nthetas = 180;
    ns=256;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RT1 = myRadon(1*(im1+im2), thetas);
    RT2 = myRadon(10*(im1+2*im3), thetas);
    RT=RT2.*(exp(-RT1));
    
    sidx = 1:sdivider:N;
    RT = RT(sidx,:);
   
    %RTF2 = filterRT2(RT, filter, 1);
    RTF2 = RT;
    %BP2 = CropCircle(radonBP2(RTF2, thetas, N));
    BP2 = radonBP2(RTF2, thetas, N);
    Result=laplacian(BP2);    
    imshow(Result/max(abs(Result(:))));