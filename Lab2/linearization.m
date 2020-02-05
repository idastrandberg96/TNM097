function [img_out] = linearization(img,r,g,b)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
x = (0:0.01:1);
img_out(:,:,1) = interp1(r,x,img(:,:,1),'pchip');
img_out(:,:,2) = interp1(g,x,img(:,:,2),'pchip');
img_out(:,:,3) = interp1(b,x,img(:,:,3),'pchip');

end

