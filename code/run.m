%    im=CropCircle(rgb2gray(im2double(imread('Lenna.png'))));

%    ´óÈ¦Ì×Ð¡È¦
    im1=zeros(512,512);
    im2=im1;
    for i=1:512
        for j=1:512
            if (i-220)^2+(j-190)^2<=225
                im1(i,j)=1;
            end
        end
    end
    for i=1:512
        for j=1:512
            if (i-170)^2+(j-200)^2<=80^2
                im2(i,j)=1;
            end
        end
    end
    im=im1+im2*3;
   
    N=size(im,1);
    nthetas = 180;
    ns=256;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RT1 = myRadon(im1, thetas);
    RT2 = myRadon(4*im2, thetas);
    RT=RT2.*(exp(RT1));
    
    sidx = 1:sdivider:N;
    RT = RT(sidx,:);
   
    RTF2 = filterRT2(RT, filter, 1);
    BP2 = CropCircle(radonBP2(RTF2, thetas, N));
    Result=BP2;
    Result(1,:)=zeros(1,N); Result(N,:)=zeros(1,N); Result(:,1)=zeros(N,1); Result(:,N)=zeros(N,1);
    for i=2:N-1
        for j=2:N-1
            Result(i,j)=4*BP2(i,j)-BP2(i-1,j)-BP2(i+1,j)-BP2(i,j-1)-BP2(i,j+1);
        end
    end
    
    imshow(Result/max(Result(:)));