    im=rgb2gray(im2double(imread('circle.png')));
    im=(im==0);


%    ´óÈ¦Ì×Ð¡È¦
%    im1=zeros(512,512);
%    im2=im1;
%    for i=1:512
%        for j=1:512
%            if (i-220)^2+(j-190)^2<=225
%                im1(i,j)=1;
%            end
%        end
%    end
%    for i=1:512
%        for j=1:512
%            if (i-170)^2+(j-200)^2<=80^2
%                im2(i,j)=1;
%            end
%        end
%    end
%    im=im1+im2*3;

%    im=zeros(512,512);
    
%    for i=230:270
%        for j=260:290
%                im(i,j)=1;
%        end
%    end

%for i=129:256
%    for j=257:384
%        if (((j-256)/128-1)^2+((256-i)/128-1)^2) >1
%            im(i,j)=1;
%        end
%    end
%end

    N=size(im,1);
    nthetas = 360;
    ns=256;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RT = myRadon(im, thetas);
    
    sidx = 1:sdivider:N;
    RT = RT(sidx,:);
   
%    RTF = filterRT2(RT, filter, 1);
    BP = radonBP2(RT, thetas, N);
    Result=BP;
    Result(1,:)=zeros(1,N); Result(N,:)=zeros(1,N); Result(:,1)=zeros(N,1); Result(:,N)=zeros(N,1);
    for i=2:N-1
        for j=2:N-1
            Result(i,j)=4*BP(i,j)-BP(i-1,j)-BP(i+1,j)-BP(i,j-1)-BP(i,j+1);
        end
    end
    
    a=showRT(RT);
    e=exp(a)-1;
    c=boundary(a);
    
    
    subplot(1,3,1);
    imshow(Result/max(Result(:)));
    subplot(1,3,2);
    imshow(a/max(a(:)));
    subplot(1,3,3);
    imshow(c);