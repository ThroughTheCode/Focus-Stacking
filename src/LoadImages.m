function Images = LoadImages(Directory)
  % This function loads every image (png, jpg, jpeg, bmp) inside a directory.
  
  % Check and correct argument
  assert(isstring(Directory) | ischar(Directory), "The path must be a string");
  if (Directory(end) == '/')
    Directory = Directory(1 : end - 1);
  end
  
  % Load Images of directory
  ImagesInDirectory = [dir(fullfile(Directory, '*.jpeg')); dir(fullfile(Directory, '*.jpg'));
                       dir(fullfile(Directory, '*.png')); dir(fullfile(Directory, '*.bmp'))];
  Images = cell(1, length(ImagesInDirectory));
  fprintf('Load Images : ');
  for i = 1 : length(ImagesInDirectory)
    fprintf('%d ', i);
    Images{i} = im2double(imread(fullfile(ImagesInDirectory(i).folder, ImagesInDirectory(i).name)));
  end
  fprintf('\n');
  
  % Assert image sizes
  assert(~isempty(Images), "No Images were loaded");
  if (length(Images) >= 2)
    for i = 2 : length(Images)
      assert(all(size(Images(1)) == size(Images(i))), "The loaded images must have the same dimensions");
    end
  end
end