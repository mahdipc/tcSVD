function [B]=inversetSVD(A)
    n3=size(A,3);
    D=fft(A,[],3);
    for i=1:n3
        B(:,:,i)=inv(squeeze(D(:,:,i)));
    end
    B=ifft(B,[],3);
end
    