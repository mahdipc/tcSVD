%% A code for t-Prodact
function C = tProdact(A,B)
    n=size(double(A),3);
    FA=fft(A,[],3);FB=fft(B,[],3);
    C=zeros([size(A,1),size(B,2),n]);
    for i=1:n
        C(:,:,i)=double(FA(:,:,i))*double(FB(:,:,i));
    end
   C=ifft(C,[],3);
end