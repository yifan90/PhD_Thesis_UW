    im1=rgb2gray(im2double(imread('bigc.png')));
    im1 = ones(256)-(im1==1);
    im2=rgb2gray(im2double(imread('smallc.png')));
    im2 = ones(256)-im2;
    im3=rgb2gray(im2double(imread('circle.png')));
    im3 = ones(256)-im3;
    
    f=(im1+im2)/2;
    g=(im1+im3)/2;
    
    im1=f;
    im2=g;
    
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
    PET = RT1.*exp(-RT2);

%    RT2 = [RT2 RT2(256:-1:1,:)];
%    RT2 = RT2(256:-1:1,:);

%    PET = [PET PET(256:-1:1,:)];
%    PET = PET(256:-1:1,:);
    
    
   % PETF = filterRT2(PET, filter, 1);
    BP = radonBP2(PET, thetas, N);
    Result=BP;
    
    Result(1,:)=zeros(1,N); Result(N,:)=zeros(1,N); Result(:,1)=zeros(N,1); Result(:,N)=zeros(N,1);
    for i=2:N-1
        for j=2:N-1
            Result(i,j)=4*BP(i,j)-BP(i-1,j)-BP(i+1,j)-BP(i,j-1)-BP(i,j+1);
        end
    end
       
    imshow(Result/max(Result(:)));
    
    
    
%    subplot(1,3,1);
%    imshow(im2);
%    subplot(1,3,2);
%    imshow(RT2/max(RT2(:)));
%    subplot(1,3,3);
%    imshow(PET/max(PET(:)));