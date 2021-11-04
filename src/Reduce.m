function ReducedImage = Reduce(Image)
  % This function blurs the image and reduces by half its size.
  Image = imfilter(Image, Kernel());
  ReducedImage = Image(1 : 2 : end, 1 : 2 : end, :);
end