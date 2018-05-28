function [FusPyr] = PyramidFusion(Pyrs, a)
[~, Level]=size(Pyrs.G);
FusPyr=Pyramid(Level, 'Laplacian');

w=Kernel(a);
for lvl=1:Level-1
    clc;
    disp(['Fusing pyramids at lvl ', num2str(lvl)]);
    LocalRegionEnergy=abs(convn(Pyrs.L{lvl}.^2, w, 'same'));
    [~, idx]=max(LocalRegionEnergy, [], 3);
    [r, c, ~]=size(Pyrs.L{lvl});
    N =r*c;
    idx  = [1:N]+(idx(1:N)-1)*N;
    FusPyr.L{lvl} = reshape(Pyrs.L{lvl}(idx), r, c);
end
clear LocalRegionEnergy; 

[~, idxE]=max((entropyfilt(Pyrs.G{end})), [], 3);
[~, idxD]=max((stdfilt(Pyrs.G{end})), [], 3);
[r, c, ~]=size(Pyrs.G{end});
N =r*c;
idx  = [1:N]+(idxE(1:N)-1)*N;
GendE= reshape(Pyrs.G{end}(idx), r, c);
idx  = [1:N]+(idxD(1:N)-1)*N;
GendD = reshape(Pyrs.G{end}(idx), r, c);
FusPyr.G{end}=(GendE+GendD)/2;
end

