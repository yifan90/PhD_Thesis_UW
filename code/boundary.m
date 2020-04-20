function [ b ] = boundary( RT )
%BOUNDARY Summary of this function goes here
%   Detailed explanation goes here
[m n]=size(RT);
b=ones(m,m);
for i=1:n
   t=firstnonzero(RT(:,i));
   s=1-(t-1)*2/m;
   b=erase(b,s,2*pi*(i-1)/n);   
end
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

function [B] = erase(b,s,theta)
B=b;
[m n]=size(b);
for i=1:m
    for j=1:n
        y=1-(i-1)*2/m;
        x=-1+(j-1)*2/n;
        if x*cos(theta)+y*sin(theta)>s
            B(i,j)=0;
        end
    end
end
end