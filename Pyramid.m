function [ PyrDef ] = Pyramid(Level, type)
switch(type)
    case 'Laplacian'
        PyrDef=struct('G', {cell(1, Level)}, 'L', {cell(1, Level)});
    case 'Gaussian'
        PyrDef=struct('G', {cell(1, Level)});
    otherwise
        error(['The type ', type, ' is unknown']);
end
end
