%    im=CropCircle(rgb2gray(im2double(imread('Lenna.png'))));



%    ´óÈ¦Ì×Ð¡È¦
    im=zeros(512,512);
%    im2=im1;
    for i=1:512
        for j=1:512
            if (i-220)^2+(j-190)^2<=160^2
                im(i,j)=1;
            end
        end
    end
    for i=1:512
        for j=1:512
            if (i-170)^2+(j-200)^2<=30^2
                im(i,j)=3;
            end
        end
    end
%    im=im1+im2*3;

%    im=zeros(512,512);
%    for i=200:370
%        for j=160:390
%                im(i,j)=1;
%        end
%    end
    
    N=size(im,1);
    nthetas = 180;
    ns=256;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RT = myRadon(im, thetas);
    
    sidx = 1:sdivider:N;
    RT = RT(sidx,:);
   
    RTF = filterRT2(RT, filter, 1);
    BP = CropCircle(radonBP2(RTF, thetas, N));
    Result=BP;
    Result(1,:)=zeros(1,N); Result(N,:)=zeros(1,N); Result(:,1)=zeros(N,1); Result(:,N)=zeros(N,1);
    for i=2:N-1
        for j=2:N-1
            Result(i,j)=4*BP(i,j)-BP(i-1,j)-BP(i+1,j)-BP(i,j-1)-BP(i,j+1);
        end
    end
    
    imshow(Result/max(Result(:)));