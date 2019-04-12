%% A code for CTSVD
function [U,S,V] = tcSVD(A,r)
    [n1 n2 n3]=size(A);
    G=dct(eye(n3));    
    Ge=G(:,1);
    
    ZI=diag(ones(n3-1,1), 1)+eye(n3);
    D=ttm(tensor(A),diag(Ge.^-1)*G*ZI,3);
    
    if nargin<=1
        for i=1:n3
            [u,s,v]=svd(double(D(:,:,i)),'econ');
            U(:,:,i)=u;
            S(:,:,i)=s;
            V(:,:,i)=v;
        end
    else
        for i=1:n3
            [u,s,v]=svds(double(D(:,:,i)),r);
            U(:,:,i)=u;
            S(:,:,i)=s;
            V(:,:,i)=v;
        end        
    end
    
    U=ttm(tensor(U),inv(ZI)*(G.*Ge)',3) ;
    S=ttm(tensor(S),inv(ZI)*(G.*Ge)',3) ;
    V=ttm(tensor(V),inv(ZI)*(G.*Ge)',3) ;
   U=double(U);S=double(S);V=double(V);
end