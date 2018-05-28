function [Gl0] =Expand(Gl1, a)
w=Kernel(a);
[Rl1, Cl1, p]=size(Gl1);
Gl0=zeros((Rl1-1)*2+1, (Cl1-1)*2+1, p);
Gl0(1:2:end, 1:2:end, :)=Gl1;
Gl0=4*convn(Gl0, w, 'same');	
end
