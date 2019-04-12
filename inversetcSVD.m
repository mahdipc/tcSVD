function [B]=inversetcSVD(A)
    n3=size(A,3);
    G=dct(eye(n3));    
    Ge=G(:,1);
    D=ttm(tensor(A),diag(Ge.^-1)*G,3);
    
    for i=1:n3
        B(:,:,i)=inv(double(D(:,:,i)));
    end
    B=ttm(tensor(B),(G.*Ge)',3) ;
    B=double(B);
end
    