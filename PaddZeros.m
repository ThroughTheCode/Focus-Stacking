function [I2, LvlMax] = PaddZeros(I1)
[row, col, Nbframe]=size(I1);
Nrow=ceil(log(row)/log(2));
Ncol=ceil(log(col)/log(2));
N=max([Nrow, Ncol]);
S=(2^N)+1;
I2=zeros(S, S, Nbframe);
I2(1:row, 1:col, :)=I1;
LvlMax=N;
end

