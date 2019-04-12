function [correctCounter]= classficistrategy(Train,Test,k,strategy)
%%
n_train=size(Train.img,2);
n_test=size(Test.img,2);
TrainMean=meanImage(Train.img);
% Train model C
A=Train.img-permute(repmat(TrainMean, 1, 1,n_train),[1,3,2]);


%% t-SVD model
if strategy=="tSVD"
    [U,~,~]=tSVD(A,k); 
    C=tProdact(tTranspose(U),A);
    % Test 
    T=Test.img-permute(repmat(TrainMean, 1, 1,n_test),[1,3,2]);
    B=tProdact(tTranspose(U),T);
%% tc-SVD model
elseif strategy=="tcSVD"
    [U,~,~]=tcSVD(A,k); 
    C=tcProdact(tcTranspose(U),A);
    % Test 
    T=Test.img-permute(repmat(TrainMean, 1, 1,n_test),[1,3,2]);
    B=tcProdact(tcTranspose(U),T);
%% fft classfication
elseif strategy=="tSVD-fft"
    D=fft(A,[],3);
    for i=1:size(A,3)/2+1
        [u,~,~]=svds(double(D(:,:,i)),k);
        U(:,:,i)=u;
    end     
    T=Test.img-permute(repmat(TrainMean, 1, 1,n_test),[1,3,2]);
    
    C=tProdact(tTranspose(U),D);
    B=tProdact(tTranspose(U),fft(T,[],3));
    %% fft classfication
elseif strategy=="tcSVD-dct"
    n3=size(A,3);
    G=dct(eye(n3));    
    Ge=G(:,1);
    D=ttm(tensor(A),diag(Ge.^-1)*G,3);
    
    for i=1:n3
        [u,~,~]=svds(double(D(:,:,i)),k);
        U(:,:,i)=u;
    end     
    T=Test.img-permute(repmat(TrainMean, 1, 1,n_test),[1,3,2]);
    
    C=tcProdact(tcTranspose(U),D);
    B=tcProdact(tcTranspose(U),double(ttm(tensor(T),diag(Ge.^-1)*G,3)));
       
end
%% Evalution
for j=1:n_test
   BC=repmat(B(:,j,:),1,n_train,1)- C;
   resh=reshape(permute(BC,[1,3,2]),[],n_train);  
   error(j,:)=sqrt(sum(resh.^2,1));
end
[~,IndexRe]=min(error);
errorIndex=Train.index(IndexRe);
correctCounter=sum(errorIndex==Test.index);

end