function w = Kernel()
    % This function returns the kernel used for expanding and reducing images of the
    % pyramid.
    a=6/16;
    w1d=[1/4-a/2; 1/4 ;a; 1/4; 1/4-a/2]; % in paper a = 6/16
    w=w1d*w1d';
end
