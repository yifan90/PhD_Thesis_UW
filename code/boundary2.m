function [ b ] = boundary2( RT )
%BOUNDARY Summary of this function goes here
%   Detailed explanation goes here
[m n]=size(RT);
s=ones(1,n);
for i=1:n
   s(i)=firstnonzero(RT(:,i));
end
b=draw(s,m);
end

function [index] = firstnonzero(RTi)
n=length(RTi);
for i=1:n
    if RTi(i)~=0
        index=i;
        break;
    end
end
end

function [b] = draw(s,m)
b=zeros(m,m);
n = length(s);
s=1-(s-1)*2/m;
for i=2:n-1
    si=1-(s(i)-1)*2/m;
    dp=(s(i+1)-s(i-1))/(4*pi/n);
    alpha=2*pi*(i-1)/n;
    phi=alpha+atan(dp/s(i));
    x=s(i)/(cos(alpha)+sin(alpha)*tan(phi));
    y=x*tan(phi);
    xi=round((x+1)*m/2)+1;
    yi=round((1-y)*m/2)+1;
    b(xi,yi)=1;
end
end