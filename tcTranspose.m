%% A code for tTranspose
function tens = tcTranspose(A)
    [n1,n2,n]=size(A);
    tens=zeros([n2,n1,n]);
    for i=1:n
        tens(:,:,i)=A(:,:,i)';
    end
    
end