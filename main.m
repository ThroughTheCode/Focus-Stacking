% Clear and close all files
clearvars; close all; clc;
addpath('./src');
tic

%% Loading Images
Images = LoadImages(%Path to folder%);

%% Generate Laplacian pyramids for each loaded image
LaplacianPyramids = DecomposeIntoLaplacianPyramid(Images);

%% Fuse the Laplacian pyramids
FusedLaplacianPyramid = FuseLaplacianPyramids(LaplacianPyramids);

%% Reconstruct from laplacian pyramids fused together
FocusedImage = ReconstructFromLaplacianPyramid(FusedLaplacianPyramid);

%% Showing the fused image
figure;
imshow(FocusedImage);
toc;