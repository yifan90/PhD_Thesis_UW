    f1=zeros(256,256); f2=f1;
    for i=1:256
        for j=1:256
            f1(i,j)=(i/100)^2+(j/200)^2;
            f2(i,j)=1+sin((i+j)/40)/2;
        end
    end

    im1=rgb2gray(im2double(imread('shell.png')));
    im1=(im1==0);
    im1=im1.*f1;
    im1=im1/max(im1(:));
   
    im2=rgb2gray(im2double(imread('shell2.png')));
    im2=4*(im2==0);
    im2=im1+im2.*f2;    
    im2=im2/max(im2(:));

    N=size(im1,1);
    nthetas = 180;
    ns=256;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RT1 = myRadon(im1, thetas);
    RT2 = myRadon(im2, thetas);
  
    
    sidx = 1:sdivider:N;
    RT1 = RT1(sidx,:);
    RT2 = RT2(sidx,:);
    a1=showRT(RT1);
    a2=showRT(RT2);
    a=a1.*exp(a2);
   
    
    
%    RTF = filterRT2(RT, filter, 1);
    BP = radonBP2(RT1.*exp(RT2), thetas, N);
    Result=BP;
    Result(1,:)=zeros(1,N); Result(N,:)=zeros(1,N); Result(:,1)=zeros(N,1); Result(:,N)=zeros(N,1);
    for i=2:N-1
        for j=2:N-1
            Result(i,j)=4*BP(i,j)-BP(i-1,j)-BP(i+1,j)-BP(i,j-1)-BP(i,j+1);
        end
    end
    
    c=boundary(a);
    
    
    subplot(1,3,1);
    imshow(Result/max(Result(:)));
    subplot(1,3,2);
    imshow(a/max(a(:)));
    subplot(1,3,3);
    imshow(c);