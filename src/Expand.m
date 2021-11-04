function ExpandedImage = Expand(Image, Dimensions)
  % This function expands an image size by 2.
  ExpandedImage = zeros(Dimensions, class(Image));
  ExpandedImage(1 : 2 : end, 1 : 2 : end, :) = Image;
  ExpandedImage = 4 * imfilter(ExpandedImage, Kernel());	
end
