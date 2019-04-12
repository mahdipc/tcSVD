%% A code for ct-Prodact
function GC = LProdact(A,B)
    A=double(A);B=double(B);
    n=size(double(A),3);
    G=dct(eye(n));   
    Ge=G(:,1); 
    
    ZI=diag(ones(n-1,1), 1)+eye(n);
    GA=ttm(tensor(A),diag(Ge.^-1)*G*ZI,3);
    GB=ttm(tensor(B),diag(Ge.^-1)*G*ZI,3); 
    for i=1:n
        GC(:,:,i)=double(GA(:,:,i))*double(GB(:,:,i));
    end   
    
    GC=ttm(tensor(GC),inv(ZI)*(G.*Ge)',3);
    GC=double(GC);
end