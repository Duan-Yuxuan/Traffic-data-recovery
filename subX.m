function X=subX(A,B,Y,Z,M,W1,W2,Omega,lambda,beta1,beta2,n1,n2,n3,n4)
%求解X子问题
for m=3:4
    AL=fft(A,[],m)/sqrt(n3);
    BL=fft(B,[],m)/sqrt(n3);
end
ABL=zeros(n1,n2,n3,n4);
for k=1:n3
    for l=1:n4
        ABL(:,:,k,l)=AL(:,:,k,l)*BL(:,:,k,l);
    end
end
for m=3:4
    AB=ifft(ABL,[],m)*sqrt(n3);
end
X=(1/(lambda+beta1+beta2))*(lambda*AB+beta1*Y+beta2*Z-W1-W2);

logicalIndex = Omega == -1;

% 使用逻辑索引直接赋值
X(~logicalIndex) = M(~logicalIndex);