%   im=CropCircle(rgb2gray(im2double(imread('Lenna.png'))));
    im1=zeros(512,512);
    im2=im1;
    im3=im1;
    for i=1:512
        x=(-513+2*i)/128;
        for j=1:512
            y=(511-2*(j-1))/128;
            if x^2+y^2<=4
                im1(i,j)=1;
            end
            if x^2+y^2<=9
                im2(i,j)=1;
            end
            if x^2+y^2<=1
                im3(i,j)=1;
            end
        end
    end

   
    N=size(im1,1);
    nthetas = 180;
    ns=512;
    sdivider = floor(N / ns);
    filter = 'ram-lak';
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
    RT1 = myRadon(im1, thetas);
    RT2 = myRadon(im2, thetas);
    RT3 = myRadon(im3, thetas);
    
    RT1=RT1.*exp(RT3-RT2);
    %sidx = 1:sdivider:N;
    %RT1 = RT1(sidx,:);
   
    RTF = filterRT2(RT1, filter, 1);
    BP = CropCircle(radonBP2(RTF, thetas, N));
    Result=BP;
  %  Result(1,:)=zeros(1,N); Result(N,:)=zeros(1,N); Result(:,1)=zeros(N,1); Result(:,N)=zeros(N,1);
  %  for i=2:N-1
  %      for j=2:N-1
  %          Result(i,j)=4*BP2(i,j)-BP2(i-1,j)-BP2(i+1,j)-BP2(i,j-1)-BP2(i,j+1);
  %      end
  %  end
    
    imshow(Result);