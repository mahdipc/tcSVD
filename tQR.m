%% A code for QR
function [Q,R] = tQR(A)
    n=size(A,3);
    D=fft(A,[],3);
    for i=1:n
        [q,r]=qr(double(D(:,:,i)),0);
        Q(:,:,i)=q;
        R(:,:,i)=r;
    end
    Q=ifft(Q,[],3);
    R=ifft(R,[],3);
end