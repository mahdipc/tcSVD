%% A code for TSVD
function [U,S,V] = tSVD(A,r)
    [n1 n2 n3]=size(A);
    D=fft(A,[],3);
%     D(:,floor(n2/64)+1:floor(63*n2/64),:)=0;
%     D(:,floor(n2/16)+1:floor(15*n2/16),floor(n3/16)+1:floor(15*n3/16))=0;
%     D(floor(n1/4)+1:floor(3*n1/4),:,floor(n3/4)+1:floor(3*n3/4))=zeros(floor(n1/2),n2,floor(n3/2));
%     D(floor(n1/4)+1:floor(3*n1/4),floor(n2/4)+1:floor(3*n2/4),:)=zeros(floor(n1/2),floor(n2/2),n3);
    
    if nargin<=1
        U=zeros([n1,min([n1,n2]),n3]);S=zeros([min([n1,n2]),min([n1,n2]),n3]);V=zeros([n2,min([n1,n2]),n3]);
        for i=1:n3
            [u,s,v]=svd(double(D(:,:,i)),'econ');
            U(:,:,i)=u;
            S(:,:,i)=s;
            V(:,:,i)=v;
        end
    else
        U=zeros([n1,r,n3]);S=zeros([r,r,n3]);V=zeros([n2,r,n3]);
        for i=1:n3
            [u,s,v]=svds(double(D(:,:,i)),r);
            U(:,:,i)=u;
            S(:,:,i)=s;
            V(:,:,i)=v;
        end        
    end
    U=ifft(U,[],3);
    S=ifft(S,[],3);
    V=ifft(V,[],3);

end