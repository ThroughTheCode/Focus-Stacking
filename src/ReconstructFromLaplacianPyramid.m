function OriginalImage = ReconstructFromLaplacianPyramid(LaplacianPyramid)
  % This function reconstruct the original image used for laplacian pyramid 
  % decomposition.
  assert(iscell(LaplacianPyramid) && isvector(LaplacianPyramid));
  GaussianPyramidLevel = LaplacianPyramid{end};
  fprintf('Collapse Laplacian Pyramid : ');
  for i = length(LaplacianPyramid) - 1 : -1 : 1
    fprintf('%d ', i);
    GaussianPyramidLevel = Expand(GaussianPyramidLevel, size(LaplacianPyramid{i})) + LaplacianPyramid{i};
  end
  OriginalImage = GaussianPyramidLevel;
  fprintf('\n');
end
