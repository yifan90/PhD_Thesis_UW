function [ y ] = ff( x )
%F 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(x);
y = x;
for i = 1:n
    a = x(i);
    if abs(a)<=1
        y(i)= 2*sqrt(4-a^2)*exp(-2*sqrt(9-a^2)+2*sqrt(1-a^2));
        continue;
    end
    if abs(a)<=2
        y(i)= 2*sqrt(4-a^2)*exp(-2*sqrt(9-a^2));
        continue;
    else
        y(i) = 0;
    end
end
end