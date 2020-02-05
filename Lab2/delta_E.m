function [test] = delta_E(XYZ,XYZ_ref)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[L,a,b] = xyz2lab(XYZ(:,1), XYZ(:,2), XYZ(:,3));

[L_ref, a_ref, b_ref] = xyz2lab(XYZ_ref(1,:), XYZ_ref(2,:), XYZ_ref(3,:));

test = sqrt((L-L_ref').^2 + (a-a_ref').^2 + (b-b_ref').^2);

end

