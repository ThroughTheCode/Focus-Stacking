function LaplacianPyramid = DecomposeIntoLaplacianPyramid(Images)
  % This function computes the laplacian pyramid of the Images(s).
  
  assert(iscell(Images) && isvector(Images), "The argument must a row cell of images.");
  NbOfImages = length(Images);

  LaplacianPyramid = cell(max(ceil(log(size(Images{1})) / log(2))), NbOfImages);
  PreviousLevel = Images;    
  NextLevel = cell(size(Images));
  fprintf('Decompose into Laplacian pyramid : ');
  for i = 1 : size(LaplacianPyramid, 1)
    fprintf('%d ', i);
    for j = 1 : NbOfImages
      NextLevel{j} = Reduce(PreviousLevel{j});
      LaplacianPyramid{i, j} = PreviousLevel{j} - Expand(NextLevel{j}, size(PreviousLevel{j}));
    end
    PreviousLevel = NextLevel;
  end
    fprintf('\n');
end