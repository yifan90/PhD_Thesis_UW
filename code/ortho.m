    
    RT = 2*rand(512,180);
    RT(1:50,:)=zeros(50,180);    
    RT(463:512,:)=zeros(50,180);
       
    N = 512;
    nthetas = 180;
    ns=256;
    sdivider = floor(N / ns);
    
    thetas = (0 : (nthetas-1))/nthetas * pi;
 
    RTF2 = filterRT2(RT, 'ram-lak', 1);
    Re=radonBP2(RTF2, thetas, N);    
    RT1 = myRadon(Re, thetas);
 
    sum(dot(RT-RT1,RT1))
    