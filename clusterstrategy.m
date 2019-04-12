function [result]= clusterstrategy(Train,cls,trunc,strategy,trunc2)

    if strategy=="tSVD_V"
        %% % Strategy tSVD_V: k-means V 
        tic;
        [~,~,v1]=tSVD(Train.img,trunc);
        tens=tTranspose(v1);
        tens=permute(tens,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3));
%         ii=kmeans(mat_u',cls);
        ii=kmeans(mat_u',cls,'MaxIter',10000,'Distance','cosine');%,'display','iter'
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans t-SVD V k=',num2str(trunc),' x_i= ',num2str(nmi_result)])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[ nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elseif strategy=="tSVD_SV"
      %% % Strategy 2: k-means S*V 
        tic;
        [~,s,v1]=tSVD(Train.img,trunc);
        tens=tProdact(s,tTranspose(v1));
        tens=permute(tens,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3));
        ii=kmeans(mat_u',cls);
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans t-SVD S*V k=',num2str(trunc),' x_i= ',num2str(nmi_result)])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strategy=="tcSVD_V"
      %% % Strategy 3: tcSVD_V: k-means V 
        tic;
        [~,~,v1]=tcSVD(Train.img,trunc);
        tens=tcTranspose(v1);
        tens=permute(tens,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3));
%         ii=kmeans(mat_u',cls);
        ii=kmeans(mat_u',cls,'MaxIter',10000,'Distance','cosine');%,'display','iter'
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans tc-SVD V k=',num2str(trunc),' x_i= ',num2str(nmi_result)])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elseif strategy=="tcSVD_SV"
      %% % Strategy 4: tcSVD_V: k-means S*V 
        tic;
        [~,s,v1]=tcSVD(Train.img,trunc);
        tens=tcProdact(s,tcTranspose(v1));
        tens=permute(tens,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3));
        ii=kmeans(mat_u',cls);
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans tc-SVD S*V k=',num2str(trunc),' x_i= ',num2str(nmi_result)])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[ nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    elseif strategy=="LSVD_V"
      %% % Strategy 3: LSVD_V: k-means V 
        tic;
        [~,~,v1]=LSVD(Train.img,trunc);
        tens=tcTranspose(v1);
        tens=permute(tens,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3));
%         ii=kmeans(mat_u',cls);
        ii=kmeans(mat_u',cls,'MaxIter',10000,'Distance','cosine');%,'display','iter'
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans L-SVD V k=',num2str(trunc),' x_i= ',num2str(nmi_result)])
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    elseif strategy=="tSVD2trunc_V"
        %% % Strategy 5: 2-trunc tSVD_V: k-means V 
        tic;
        [~,~,v1]=tSVD(Train.img,trunc);        
        tens=tTranspose(v1);        
        tens=permute(tens,[3,2,1]);
        [~,~,v2]=tSVD(tens,trunc2);
        tens=tTranspose(v2);  
        tens=permute(tens,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3));
        ii=kmeans(mat_u',cls,'Distance','cosine');
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans t-SVD V k1=',num2str(trunc),' k2=',num2str(trunc2),' x_i= ',num2str(nmi_result)])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi(:)=[nmiC avgent];
        result.ACC=ACC;
        result.compute_f(:)=[f,p,r]';
        result.RandIndex(:)=[AR,RI,MI,HI]';
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     elseif strategy=="tcSVD2trunc_V"
      %% % Strategy 6: 2-trunc tcSVD_V: k-means V 
        tic;
        [~,s1,v1]=tcSVD(Train.img,trunc);        
        tens=tProdact(s1,tcTranspose(v1));        
        tens=permute(tens,[3,2,1]);
        [~,~,v2]=tcSVD(tens,trunc2);
        tens=tcTranspose(v2);  
        tens=permute(tens,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3));
        ii=kmeans(mat_u',cls,'Distance','cosine');
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans tc-SVD V k1=',num2str(trunc),' k2=',num2str(trunc2),' x_i= ',num2str(nmi_result)])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    elseif strategy=="HOSVD"
      %% % Strategy 7: HOSVD: k-means V 
        tic;
        [~,u]=HOSVD(tensor(Train.img),0,[1,trunc,1]);
%        ii=kmeans(u{2},cls,'MaxIter',10000,'Distance','cosine');%,'display','iter'
         ii=kmeans(u{2},cls);
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans HOSVD U2 k=',num2str(trunc),' x_i= ',num2str(nmi_result)])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strategy=="NMF"
        tic;
        tens=permute(Train.img,[1,3,2]);
        mat_u=reshape(tens,[],size(tens,3))';
        [w,~]=nnmf(mat_u,trunc);
        %ii=kmeans(w,cls,'MaxIter',10000,'Distance','cosine');%,'display','iter'
        ii=kmeans(w,cls);%,'display','iter'
        toc;
        result.Timeing=toc;
        nmi_result=nmi(ii,Train.index);
        disp(['nmi kmeans NMF W k=',num2str(trunc),' x_i= ',num2str(nmi_result)])
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [~, nmiC ,avgent] = compute_nmi(ii,Train.index);
        ACC = Accuracy(Train.index,double(ii));
        [f,p,r] = compute_f(ii,Train.index);
        [AR,RI,MI,HI]=RandIndex(ii,Train.index);
        result.compute_nmi=[nmiC avgent];
        result.ACC=ACC;
        result.compute_f=[f,p,r];
        result.RandIndex=[AR,RI,MI,HI];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end