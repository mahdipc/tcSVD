function [M]= meanImage(A)
[n1 n2 n3]=size(A);
%     M=zeros(n1,1,n3); %mean image
%     for i=1:n2
%         M=M+double(A(:,i,:));
%     end

%     M=squeeze((1./n2).*sum(A,2));
  M=squeeze(std(permute(A,[2,1,3])));
end