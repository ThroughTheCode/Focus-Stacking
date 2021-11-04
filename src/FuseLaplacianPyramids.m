function FusedLaplacianPyramid = FuseLaplacianPyramids(LaplacianPyramids)
  % This function computes the fusion of the pyramids at each level according to
  % the local region energy for all the levels excepting the top for which we 
  % use a criteria of entropy and standard deviation.

  assert(iscell(LaplacianPyramids) && ismatrix(LaplacianPyramids), "The argument must be a cell matrix of laplacian pyramid.");
  
  % Parameters
  PyramidHeight = size(LaplacianPyramids, 1);
  NbOfChannels = size(LaplacianPyramids{1}, 3);
  NbOfImages = size(LaplacianPyramids, 2);
  Type = class(LaplacianPyramids{1});
  FusedLaplacianPyramid = cell(size(LaplacianPyramids, 1), 1);
  
  % Applying the criteria of maximal local region energy
  fprintf('Fusing Laplacian Pyramids : ');
  for i = 1 : PyramidHeight - 1
    fprintf('%d ', i);
    [Height, Width, ~] = size(LaplacianPyramids{i, 1});
    Level = zeros([Height, Width, NbOfImages], Type);
    RegionEnergy = Level;
    FusedLevel = zeros([Height, Width, NbOfChannels], Type);
    for j = 1 : NbOfChannels
        for k = 1 : NbOfImages
            Level(:, :, k) = LaplacianPyramids{i, k}(:, :, j);
            RegionEnergy(:, :, k) = imfilter(Level(:, :, k).^2, Kernel());
        end
        [~, Index] = max(RegionEnergy, [], 3, 'linear');
        FusedLevel(:, :, j) = Level(Index);
    end
    FusedLaplacianPyramid{i} = FusedLevel;
  end
  
  % Applying the criteria of maximal entropy and standard deviation
  [Height, Width, ~] = size(LaplacianPyramids{end, 1});
  Entropy = zeros([Height, Width, NbOfImages], Type);
  STD = Entropy;
  Level = STD;
  FusedLevel = zeros([Height, Width, NbOfChannels], Type);

  for i = 1 : NbOfChannels
    for j = 1 : NbOfImages
        Level(:, :, j) = LaplacianPyramids{end, j}(:, :, i);
        Entropy(:, :, j) = entropyfilt(Level(:, :, j));
        STD(:, :, j) = stdfilt(Level(:, :, j));
    end
    [~, IndexForMaxEntropy] = max(Entropy, [], 3, 'linear');
    [~, IndexForMaxSTD] = max(STD, [], 3, 'linear');
    FusedLevel(:, :, i) = (Level(IndexForMaxEntropy) + Level(IndexForMaxSTD)) / 2;
  end
  FusedLaplacianPyramid{end} = FusedLevel;
end
