function [IP]= ILP(Pyr, a)
[~, Level]=size(Pyr.G);

for i=Level-1:-1:1
    clc;
    disp(['Collapse pyramid at level : ', num2str(i)]);
    Pyr.G{i}=Expand(Pyr.G{i+1}, a)+Pyr.L{i};
    Pyr.G{i+1}={};
end
IP=Pyr;
end


