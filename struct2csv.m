function struct2csv(s,DBName)

headers = fieldnames(s);

datas=struct2cell(s);
for i=1:size(datas,1)
    ss=squeeze(datas(i,:,:));
    matR=cell2mat(ss(2:end));
    
    csvwrite(DBName+'_'+headers{i}+'.txt',matR);
end
