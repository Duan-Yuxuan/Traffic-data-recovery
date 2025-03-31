function Y=subY(X,invRT1,invR1,W1,beta1,n1,n2,n3,n4)
%求解Y子问题

XW1=beta1*X+W1;
Mat1X=zeros(n1,n2*n3*n4);
for i=1:n1
    Mat1X(i,:)=reshape(XW1(i,:,:,:),[1,n2*n3*n4]);
end


Mat1Y=invR1*invRT1*Mat1X;
Y=zeros(n1,n2,n3,n4);
for i=1:n1
    Y(i,:,:,:)=reshape(Mat1Y(i,:),[n2,n3,n4]);
end