function [IGoGMag, IGoGArg]= GoGFilter(I, sigma)    
     [Ix, Iy]=GoGFilterXY(I, sigma);
     IGoGMag=(Ix.^2+Iy.^2).^0.5;
     IGoGArg=atan2(Iy, Ix);
end

function [IGoGx, IGoGy]= GoGFilterXY(I, sigma)
     disp('Applying GoG filter');
     x=-2:2;
     y=x;
     [X, Y]=meshgrid(x, y);
     GoGx=exp(-(X.^2+Y.^2)/(2*sigma^2)).*(-X)/(2*pi*sigma^4);
     GoGy=exp(-(X.^2+Y.^2)/(2*sigma^2)).*(-Y)/(2*pi*sigma^4)';
     IGoGx=convn(I, GoGx, 'same');
     IGoGy=convn(I, GoGy, 'same');
end