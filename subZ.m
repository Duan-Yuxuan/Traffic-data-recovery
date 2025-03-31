function Z=subZ(X,invRT2,invR2,W2,beta2,n1,n2,n3,n4)
%求解Z子问题

XW2=beta2*X+W2;
Mat2X=zeros(n2,n1*n3*n4);
for j=1:n2
    Mat2X(j,:)=reshape(XW2(:,j,:,:),[1,n1*n3*n4]);
end


Mat2Z=invR2*invRT2*Mat2X;
Z=zeros(n1,n2,n3,n4);
for j=1:n2
    Z(:,j,:,:)=reshape(Mat2Z(j,:),[n1,n3,n4]);
end