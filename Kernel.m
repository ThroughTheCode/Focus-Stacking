function [w2d] = Kernel(a)
w1d=[1/4-a/2; 1/4 ;a; 1/4; 1/4-a/2];
w2d=w1d*w1d';
end

