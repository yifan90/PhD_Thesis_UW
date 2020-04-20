function [ R ] = laplacian( im )
%LAPLACIAN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
R = im;
N = size(im,1);
    for i=2:N-1
        for j=2:N-1
            R(i,j)=4*im(i,j)-im(i-1,j)-im(i+1,j)-im(i,j-1)-im(i,j+1);
        end
    end
R(1,:)=zeros(1,N); R(N,:)=zeros(1,N); R(:,1)=zeros(N,1); R(:,N)=zeros(N,1);
end

