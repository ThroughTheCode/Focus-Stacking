function [IRGB, IBW, H, W, nbframe]=LoadingImg(directory, imgname, nostart, noend, imgext, imgsize)
nbframe=noend-nostart+1;
imginfo=imfinfo([directory, imgname, num2str(nostart), imgext]);
ResizeImg=true;
if (imgsize~=0 && imgsize~=1)
    H=ceil(imginfo.Height*imgsize); W=ceil(imginfo.Width*imgsize);
else
    H=(imginfo.Height); W=(imginfo.Width);
    ResizeImg=false;
end
IRGB=zeros(H, W, 3*nbframe, 'uint8');
IBW=zeros(H, W, nbframe);
idx=1:3;
for i=1:nbframe
    clc;
    disp(['Loading Img n°',num2str(i),'/', num2str(nbframe)]);
    filename=[directory, imgname, num2str(nostart+i-1), imgext];
    if(ResizeImg)
        IRGB(:,:, idx)=imresize(imread(filename), imgsize);
    else
        IRGB(:,:,idx)=imread(filename);
    end
    IBW(:, :, i)=RGB2BW(IRGB(:,:, idx));
    idx=idx+3;
end
end

function [gray]=  RGB2BW(rgb)
  [~, ~, p]=size(rgb);
  if(p~=3)
    error('It is not a RGB image');
  end
  if(isa(rgb, 'uint8'))
    rgb=im2double(rgb);
  end
  gray=sum(rgb, 3)/3;
end
