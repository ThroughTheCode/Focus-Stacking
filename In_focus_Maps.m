function [InfocusMaps] = In_focus_Maps(IBW, sigma, threshold_for_quantile, se_size)
    [H, W, nbframe]=size(IBW);

    %% Generating edges maps
    clc; disp('Generate Edges Maps');
    EdgesMaps=GoGFilter(IBW, sigma);
    WeightingEdgesMaps=EdgesMaps.^2./repmat(sum(EdgesMaps.^2, 3), [1, 1, nbframe]);
    clear EdgesMaps;

    %% Generating binary maps
    BinaryMasks=zeros(H, W, nbframe, 'logical');
    for i=1:nbframe
        clc;
        disp(['Generating Binary Maps ', num2str(i), '/', num2str(nbframe)])
        threshold=quantile(sort(reshape(WeightingEdgesMaps(:,:,i), [1, H*W])), threshold_for_quantile);
        BinaryMasks(:,:,i)=WeightingEdgesMaps(:,:,i)>threshold;
    end
    clear WeightingEdgesMaps;

    %% Removing Island from binary masks
    %BinaryMasks=RemoveIslands(BinaryMasks, 1, 4);

    %% Extending Binary masks
    clc; disp('Extending In_focus_Maps');
    se=strel('diamond', se_size);
    InfocusMaps=imdilate(BinaryMasks, se);
end

function [IOut] = RemoveIslands(I, N, P)
    IOut=I;
    [~, ~, nbframe]=size(I);
    for k=1:nbframe
        clc; disp(['Remove Island n°', num2str(k), '/', num2str(nbframe)]);
        [row, col]=find(I(:,:,k));
        NonZeroElts=length(row);
        Padd=padarray(I(:,:,k), [N, N], 'both');
        S=zeros(2*N+1, 2*N+1, NonZeroElts);
        for l=1:NonZeroElts
            S(:,:,l)=Padd(row(l):row(l)+2*N, col(l):col(l)+2*N);
        end
        temp=squeeze(sum(sum(S)));
        idx=find(temp<=P);
        if(~isempty(idx))
            for l=1:max(size(idx))
                IOut(row(idx(l)), col(idx(l)), k)=0;
            end
        end
    end
end
