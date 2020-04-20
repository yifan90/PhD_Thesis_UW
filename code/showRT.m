function [ a ] = showRT( RT )
%SHOWRT Summary of this function goes here
%   Detailed explanation goes here
[m n]=size(RT);
a=RT; a(m,2*n)=0;
for i=1:n
    temp=RT(:,i);
    a(:,i+n)=reshape(temp(m:-1:1),m,1);
end
for i=1:2*n
    temp=a(:,i);
    a(:,i)=reshape(temp(m:-1:1),m,1);
end
end

