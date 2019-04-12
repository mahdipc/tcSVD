%% A code for incremental TSVD
function [Unew,Snew,Vnew] = incrementalTSVD( U, S, V, ten,Y)

    n=size(S,3);
    fU=fft(U,[],3);
    fS=fft(S,[],3);
    fV=fft(V,[],3);
    ftensor=fft(ten,[],3);
    fY=fft(Y,[],3);
    for i=1:n
        [u,s,v]=incrementalSVD(fU(:,:,i),fS(:,:,i),fV(:,:,i),ftensor(:,:,i),false);
        Unew(:,:,i)=u;
        Snew(:,:,i)=s;
        Vnew(:,:,i)=v;
    end
    Unew=ifft(Unew,[],3);
    Snew=ifft(Snew,[],3);
    Vnew=ifft(Vnew,[],3);
end