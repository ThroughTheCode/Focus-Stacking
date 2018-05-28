clc; close all; clear;
tic
%% Loading Images
[~, IBW, H, W, nbframe]=LoadingImg('Demo_from_Helicon_Focus/', 'DSC0', 8953, 8956, '.jpg', 1);

%% Generating in-focus maps
sigma=0.5;
threshold_for_quantile=0.8; % 0<t<1
se_size=10;
InfocusMaps = In_focus_Maps(IBW, sigma, threshold_for_quantile, se_size);

%% Generating binary maps and gray leveled pyramids
a=0.5;
InfocusGP=StackGP(InfocusMaps, a);
IBWLP=StackLP(IBW, a);
for i=1:size(InfocusGP.G, 2)
    IBWLP.L{i}=IBWLP.L{i}.*InfocusGP.G{i};
end
clear InfocusMaps;

%% Fusing Pyramids
FusedLP=PyramidFusion(IBWLP, a);
clear IBW;

%% Generating all-in-focus BW image
FusedLP=ILP(FusedLP, a);
Iref=FusedLP.G{1}(1:H, 1:W);
clear FusedLP;
figure;
imshow(Iref);
toc;
