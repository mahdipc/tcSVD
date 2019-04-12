%% A code for CTSVD
function [U,S,V] = tcSVD(A,r)
    [n1 n2 n3]=size(A);
    G=dct(eye(n3));    
    Ge=G(:,1);
    
%     ZI=diag(ones(n3-1,1), 1)+eye(n3);
%     D=ttm(tensor(A),diag(Ge.^-1)*G*ZI,3);
    
    D=ttm(tensor(A),diag(Ge.^-1)*G,3);
%     D=ttm(tensor(A),G./Ge,3);       
%     D(:,floor(n2/32)+1:n2,:)=0;
%     D(:,floor(n2/8)+1:n2,floor(n3/8)+1:n3)=0;
%     D(floor(n1/2)+1:n1,:,floor(n3/2)+1:n3)=zeros(floor(n1/2),n2,floor(n3/2));
%     D(floor(n1/2)+1:n1,floor(n2/2)+1:n2,:)=zeros(floor(n1/2),floor(n2/2),n3);
      
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
    
%     U=ttm(tensor(U),inv(ZI)*(G.*Ge)',3) ;
%     S=ttm(tensor(S),inv(ZI)*(G.*Ge)',3) ;
%     V=ttm(tensor(V),inv(ZI)*(G.*Ge)',3) ;
   U=ttm(tensor(U),(G.*Ge)',3) ;
   S=ttm(tensor(S),(G.*Ge)',3) ;
   V=ttm(tensor(V),(G.*Ge)',3) ;
   U=double(U);S=double(S);V=double(V);
%     U=idct(U,[],3);
%     S=idct(S,[],3);
%     V=idct(V,[],3);

%     A-tcProdact(double(U),tcProdact(double(S),tcTranspose(double(V))))
end