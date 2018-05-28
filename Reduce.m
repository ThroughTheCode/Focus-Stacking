function [Gl1] =Reduce(Gl0, a)
w=Kernel(a);
Gl0=convn(Gl0, w, 'same');
Gl1=Gl0(1:2:end, 1:2:end, :);
end
