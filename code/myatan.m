function [ phi ] = myatan( v )
%ATAN2 Summary of this function goes here
%   Detailed explanation goes here
if v(1)==0
    if v(2)>0
        phi=pi/2;
        return;
    else
        phi=3*pi/2;
        return
    end
end
phi=atan(v(2)/v(1));
if v(2)/v(1)>0
    if v(1)>0
        return
    else
        phi=pi+phi;
    end
else
    if v(1)>0
        phi=phi+2*pi;
    else
        phi=phi+pi;
    end
end
end

