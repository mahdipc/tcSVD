%% A code for tTranspose
function tens = tTranspose(A)
    tens(:,:,1)=A(:,:,1)';
    n=size(A,3);
    for i=n:-1:2
        tens(:,:,n-i+2)=A(:,:,i)';
    end
    
end